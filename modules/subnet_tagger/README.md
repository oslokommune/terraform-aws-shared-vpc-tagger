# subnet_tagger

Tags shared subnet

## Subnet names

If **not** shared subnet: `$team-$tier-$azid`, ie: `informasjonsflyt-private-eun1-az1`.
If shared: `$vpcname-$tier-$azid`, ie: `helsedata-public-eun1-az1`

## Usage

First set up [tagger_config](/modules/tagger_config/)

```terraform
module "private_subnets" {
  source        = "git@github.com:oslokommune/terraform-vpc-tagger.git//modules/subnet_tagger?ref=v1"
  tier          = "private"
  tagger_config = module.tagger_config

  ids = [
    "subnet-0d18e033f814375b0",
    "subnet-008326aa5632e7e6f",
    "subnet-0de111e589b840c16",
  ]
}

module "public_subnets" {
  source         = "git@github.com:oslokommune/terraform-vpc-tagger.git//modules/subnet_tagger?ref=v1"
  tier           = "nhn"
  shared         = true
  tagger_config  = module.tagger_config

  ids = [
    "subnet-0f852404165777b60",
    "subnet-025553b8a2fbbb483",
    "subnet-0a6230f801fba9bdc",
  ]
}
```

## Input

| Variable | Type | Description |
| --- | --- | --- |
| ids | list | List of subnet ids to tag |
| tier | string | Type of subnets (private/public/database/...) |
| shared | bool | Set to true if other teams also deploys to these subnets |
| tagger_config | object | Set to `tagger_config` module |
| tags | map | Extra tags, optional |

Setting `shared` to `true` adds a `Shared = "yes"` tag to the subnets and
changes the naming convention.

## Output

| Output | Type | Description |
| --- | --- | --- |
| ids | list | List of subnet ids |
| subnets | list | List of [subnet data source objects](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnet) |
