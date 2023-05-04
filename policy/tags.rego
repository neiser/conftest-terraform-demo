package tags

deny_missing_tags[msg] {
	# please code the correct policy here and craft a 'msg' with proper sprintf input
  	msg := sprintf("%v.%v is missing tags", ["provide resource type", "provide resource name"])
}
