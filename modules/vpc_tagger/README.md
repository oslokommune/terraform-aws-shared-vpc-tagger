## vpc_tagger

Tags shared VPC

### Usage

```terraform
module "shared_vpc" {
  source = "oslokommune/shared-vpc-tagger/aws"
  id     = "vpc-123"
  name   = local.vpc_name

  tags = merge(local.common_tags, {
    Name = local.vpc_name
  })
}
```

### Input

| Variable | Type | Description |
| --- | --- | --- |
| id | string | ID of VPC to tag |
| name | object | Name of VPC |
| tags | map | Taggy tags |

### Output

| Output | Type | Description |
| --- | --- | --- |
| id | string | VPC ID |
| vpc | object | [VPC data source object](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/vpc) |
