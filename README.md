[![Open in Gitpod](https://gitpod.io/button/open-in-gitpod.svg)](https://gitpod.io/#https://github.com/neiser/conftest-terraform-demo/tree/demo/02-tags-ignore)

# Task 2: Deny resources which do not ignore tags lifecycle

If a task has `tags` attribute, it should also ignore changes to that attribute using [Terraform lifecycle statement](https://developer.hashicorp.com/terraform/language/meta-arguments/lifecycle#ignore_changes).

For example:
```hcl
# This is ok!
resource "managed_disk" "foo" {
  size = "100GB"
  tags = { "tagKey": "someTagValue"}
  lifecycle {
    ignore_changes = [
      tags,
    ]
  }
}

# This is invalid (should be denied):
resource "managed_disk" "foo" {
  size = "100GB"
  tags = { "tagKey": "someTagValue"}
}
```

Run 
```shell
conftest verify
```
to see that some testcases are broken and fix them by coding in [policy/tags.rego](policy/tags.rego).