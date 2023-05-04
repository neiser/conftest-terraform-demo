package single_resource_this

no_violations {
	count(deny_single_resource_not_this) == 0
}

test_blank_input {
	no_violations with input as build_test_input([])
}

test_one_file_distinct_resources_this {
	input := build_test_input_one_file([resource1this, resource2this])
	no_violations with input as input
}

test_one_file_distinct_resources {
	input := build_test_input_one_file([resource1foo, resource2bar])
	deny_single_resource_not_this["resource type1 exists once with name foo != this (test.tf)"] with input as input
	deny_single_resource_not_this["resource type2 exists once with name bar != this (test.tf)"] with input as input
}

test_one_file_same_resources {
	input := build_test_input_one_file([resource1foo, resource1bar])
	no_violations with input as input
}

test_one_file_same_resources_ignored {
	input := build_test_input_one_file([resource2this, resource2ignored])
	no_violations with input as input
}

test_one_file_three_resources {
	input := build_test_input_one_file([resource1foo, resource1bar, resource2this])
	no_violations with input as input
}

test_one_file_four_resources {
	input := build_test_input_one_file([resource1foo, resource1bar, resource2this, resource2bar])
	no_violations with input as input
}

test_one_file_same_resources_this {
	input := build_test_input_one_file([resource1this, resource1bar])
	no_violations with input as input
}

test_two_files_distinct_resources_this {
	input := build_test_input([resource1this, resource2this])
	no_violations with input as input
}

test_two_files_distinct_resources {
	input := build_test_input([resource1foo, resource2bar])
	deny_single_resource_not_this["resource type1 exists once with name foo != this (test0.tf)"] with input as input
	deny_single_resource_not_this["resource type2 exists once with name bar != this (test1.tf)"] with input as input
}

test_two_files_same_resources {
	input := build_test_input([resource1foo, resource1bar])
	no_violations with input as input
}

test_four_files_four_resources {
	input := build_test_input([resource1foo, resource1bar, resource2this, resource2bar])
	no_violations with input as input
}

test_two_files_five_resources {
	input := build_test_input([concat("\n", [resource1foo, resource1bar, resource1this]), concat("\n", [resource2this, resource2bar])])
	no_violations with input as input
}

test_two_files_distinct_and_same_resources {
	input := build_test_input([concat("\n", [resource1foo, resource1bar]), concat("\n", [resource2bar])])
	deny_single_resource_not_this["resource type2 exists once with name bar != this (test1.tf)"] with input as input
}

resource1this := `
resource "type1" "this" {
    property1 = "value1"
}`

resource1foo := `
resource "type1" "foo" {
    property1 = "value1"
}`

resource1bar := `
resource "type1" "bar" {
    property1 = "value1"
}`

resource2this := `
resource "type2" "this" {
    property1 = "value1"
}`

resource2bar := `
resource "type2" "bar" {
    property1 = "value1"
}`

resource2ignored := `
resource "type2" "ignored" {
    property1 = "value1"
}`

build_test_entry(path, content) := {"path": path, "contents": parse_config("hcl2", content)}

build_test_input_one_file(contents) := [build_test_entry("test.tf", concat("\n", contents))]

build_test_input(contents) := [build_test_entry(sprintf("test%v.tf", [i]), content) |
	content := contents[i]
]
