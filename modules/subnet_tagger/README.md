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
