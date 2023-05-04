package single_resource_this

deny_single_resource_not_this[msg] {
	# as resource may be defined across multiple input files,
	# first collect all resource types, then count names

	# please code here!

	msg := sprintf("resource %v exists once with name %v != this (%v)", ["the resource type", "the resource name", input[i].path])
}
