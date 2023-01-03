# terraform-aws-shared-vpc-tagger

Tags VPCs and subnets that you did not create yourself (ie. shared VPCs)

## Submodules

 - [vpc_tagger](./modules/vpc_tagger)
 - [subnet_tagger](./modules/subnet_tagger)

## Usage

```terraform
locals {
  team_name   = "myteam"
  environment = "dev"
  vpc_name    = "coolvpc"

  common_tags = {
    Team        = local.team_name
    Environment = local.environment
  }
}

module "shared_vpc" {
  source  = "oslokommune/shared-vpc-tagger/aws"

  vpc = {
    id   = "vpc-123"
    name = local.vpc_name
  }

  subnets = {
    private = {
      name_prefix = local.team_name

      ids = [
        "subnet-1",
        "subnet-2",
        "subnet-3",
      ]
    }

    public = {
      name_prefix = local.vpc_name

      tags = {
        Shared = "yes"
      }

      ids = [
        "subnet-4",
        "subnet-5",
        "subnet-6",
      ]
    }
  }

  tags = merge(local.common_tags, {
    VpcName = local.vpc_name
  })
}
```

### Input

| Variable | Type | Description |
| --- | --- | --- |
| vpc | vpc_object | VPC object |
| subnets | list(subnet_object) | List of subnet objects |
| tags | map | Tags for all resources, VPC and subnets |

#### vpc_object

| Key | Type | Description |
| --- | --- | --- |
| id | string | ID of the VPC |
| name | string | Name for the subnet |
| tags | map | Extra tags for the VPC. Optional. |

#### subnet_object

| Variable | Type | Description |
| --- | --- | --- |
| ids | list | List of subnet ids to tag |
| name_prefix | string | First part of subnet name. |
| tier | string | Type of subnets (private/public/database/...). Also used as second part of subnet name. |
| tags | map | Extra tags for subnets. Optional. |

Subnets are named: `$name_prefix-$tier-$az_id`

Ie. `myteam-private-eun1-az1`

### Output

| Output | Type | Description |
| --- | --- | --- |
| vpc_id | string | VPC ID |
| vpc | object | [VPC data source object](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/vpc) |
| subnet_ids | list(string) | List of subnet ids |
| subnets | map(map(object)) | Map of [subnet data source objects](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnet). First key is tier, second key is availability zone id.|
