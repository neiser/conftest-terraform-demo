package tags

deny_missing_tags[msg] {
    resource = input.resource[type][name]
	not resource.tags
	msg := sprintf("%v.%v is missing tags", [type, name])
}

deny_tags_lifecycle_unignored[msg] {
    resource = input.resource[type][name]
    resource.tags
    not ignores_tags_in_lifecycle(resource)
	msg := sprintf("%v.%v does not ignore changes of tags attribute", [type, name])
}

ignores_tags_in_lifecycle(resource) {
    resource.lifecycle.ignore_changes[_] = "${tags}"
}
