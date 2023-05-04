[![Open in Gitpod](https://gitpod.io/button/open-in-gitpod.svg)](https://gitpod.io/#https://github.com/neiser/conftest-terraform-demo/tree/demo/03-enforce-this)

# Task 3: Enforce using "this" for singleton resources

When naming Terraform resources, the convention should be enforced that if the resource type is only used once, the resource should be named `"this"`.

For example, this is ok:
```hcl
resource "managed_disk" "this" { 
  size = "100GB"
}
```

This is also ok:
```hcl
resource "managed_disk" "foo" { 
  size = "100GB"
}

# might be located in different *.tf file:
resource "managed_disk" "bar" { 
  size = "100GB"
}
```

But this is not ok:
```hcl
resource "managed_disk" "foo" { 
  size = "100GB"
}
```

Note that this is a policy spreading all `*.tf` files, 
and the `conftest` tool needs to be run with `--combine` when actually checking Terraform configuration files.

Again, run
```shell
conftest verify
```
to see that some testcases are broken and fix them by coding in [policy/single_resource_this.rego](policy/single_resource_this.rego).
The `build_test_input` in the test has been adapted to match the input when the `--combine` flag is used.
