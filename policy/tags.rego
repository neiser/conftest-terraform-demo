package tags

deny_missing_tags[msg] {
    resource = input.resource[type][name]
	not resource.tags
	msg := sprintf("%v.%v is missing tags", [type, name])
}
