package single_resource_this

deny_single_resource_not_this[msg] {
	# as resource may be defined across multiple input files,
	# first collect all resource types, then count names
	resource_types := {resource_type |
		input[_].contents.resource[resource_type]
	}
	resource_types[resource_type]
	count({name | some i, name; input[i].contents.resource[resource_type][name]}) == 1

	# the count above ensures that the resource has only one name, capture this then here
	input[i].contents.resource[resource_type][name]
	name != "this"
	msg := sprintf("resource %v exists once with name %v != this (%v)", [resource_type, name, input[i].path])
}
