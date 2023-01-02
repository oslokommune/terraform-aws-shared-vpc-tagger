# terraform-aws-vpc-tagger

Tags VPCs and subnets that you did not create yourself (ie. shared VPCs)

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
  source = "git@github.com:oslokommune/terraform-vpc-tagger.git//modules/vpc_tagger?ref=v1"
  id     = "vpc-123"
  name   = local.vpc_name

  tags = merge(local.common_tags, {
    Name = local.vpc_name
  })
}

module "private_subnets" {
  source      = "git@github.com:oslokommune/terraform-vpc-tagger.git//modules/subnet_tagger?ref=v1"
  name_prefix = local.team_name
  tier        = "private"
  tags        = local.common_tags

  ids = [
    "subnet-123",
    "subnet-124",
    "subnet-125",
  ]
}

module "public_subnets" {
  source      = "git@github.com:oslokommune/terraform-vpc-tagger.git//modules/subnet_tagger?ref=v1"
  name_prefix = local.vpc_name
  tier        = "public"

  tags = merge(local.common_tags, {
    Shared = "yes"
  })

  ids = [
    "subnet-456",
    "subnet-457",
    "subnet-458",
  ]
}
```

## vpc_tagger

Tags shared VPC

### Usage

```terraform
module "shared_vpc" {
  source = "git@github.com:oslokommune/terraform-vpc-tagger.git//modules/vpc_tagger?ref=v1"
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

## subnet_tagger

Tags shared subnet

### Subnet names

Full subnet name: `$name_prefix-$tier-$az_id`

Ie. `myteam-private-eun1-az1`

### Usage

```terraform
module "private_subnets" {
  source      = "git@github.com:oslokommune/terraform-vpc-tagger.git//modules/subnet_tagger?ref=v1"
  name_prefix = local.team_name
  tier        = "private"
  tags        = local.common_tags

  ids = [
    "subnet-123",
    "subnet-124",
    "subnet-125",
  ]
}

module "public_subnets" {
  source      = "git@github.com:oslokommune/terraform-vpc-tagger.git//modules/subnet_tagger?ref=v1"
  name_prefix = local.vpc_name
  tier        = "public"

  tags = merge(local.common_tags, {
    Shared = "yes"
  })

  ids = [
    "subnet-456",
    "subnet-457",
    "subnet-458",
  ]
}
```

### Input

| Variable | Type | Description |
| --- | --- | --- |
| ids | list | List of subnet ids to tag |
| name_prefix | string | First part of subnet name. |
| tier | string | Type of subnets (private/public/database/...). Also used as second part of subnet name. |
| tags | map | Taggy tags |

### Output

| Output | Type | Description |
| --- | --- | --- |
| ids | list | List of subnet ids |
| subnets | map | Map of [subnet data source objects](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnet). Keys are availability zone ids. |
