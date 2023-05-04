package tags

no_violations {
	count(deny_missing_tags) == 0
	count(deny_tags_lifecycle_unignored) == 0
}

test_blank_input {
	no_violations with input as {}
}

test_resource_with_tags_and_ignore_changes {
	input := `
		resource "managed_disk" "foo" {
			size = "100GB"
			tags = { "tagKey": "someTagValue"}
			lifecycle {
              ignore_changes = [
                tags,
              ]
            }
		}
	`

	no_violations with input as build_test_input(input)
}

test_resource_missing_ignore_changes {
	input := `
		resource "managed_disk" "foo" {
			size = "100GB"
			tags = { "tagKey": "someTagValue"}
		}
	`
	deny_tags_lifecycle_unignored["managed_disk.foo does not ignore changes of tags attribute"] with input as build_test_input(input)
}


build_test_input(contents) := parse_config("hcl2", contents)
