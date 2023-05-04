package tags

no_violations {
	count(deny_missing_tags) == 0
}

test_blank_input {
	no_violations with input as {}
}

test_resource_with_tags {
	input := `
		resource "managed_disk" "foo" {
			size = "100GB"
			tags = { "tagKey": "someTagValue"}
		}
	`

	no_violations with input as build_test_input(input)
}

test_resource_missing_tags {
	input := `
		resource "managed_disk" "foo" {
			size = "100GB"
		}
	`

	deny_missing_tags["managed_disk.foo is missing tags"] with input as build_test_input(input)
}


build_test_input(contents) := parse_config("hcl2", contents)
