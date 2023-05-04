[![Open in Gitpod](https://gitpod.io/button/open-in-gitpod.svg)](https://gitpod.io/#https://github.com/neiser/conftest-terraform-demo/tree/demo/01-tags)

# Task 1: Deny resources without tags

Any resource should have a `tags` key (with an arbitrary value). 

For example:
```hcl
# This is ok!
resource "managed_disk" "foo" {
  size = "100GB"
  tags = { "tagKey": "someTagValue"}
}

# This is invalid (should be denied):
resource "managed_disk" "foo" {
  size = "100GB"
}
```

Run 
```shell
conftest verify
```
to see that all testcases are broken and fix them by coding in [policy/tags.rego](policy/tags.rego).