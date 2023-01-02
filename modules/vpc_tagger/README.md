# vpc_tagger

Tags shared VPC

## Usage

First set up [tagger_config](/modules/tagger_config/)

```terraform
module "shared_vpc" {
  source         = "git@github.com:oslokommune/terraform-vpc-tagger.git//modules/vpc_tagger?ref=v1"
  id             = "vpc-05086887c0451b882"
  tagger_config  = module.tagger_config
}
```

## Input

| Variable | Type | Description |
| --- | --- | --- |
| id | string | ID of VPC to tag |
| tagger_config | object | Set to `tagger_config` module |
| tags | map | Extra tags, optional |

## Output

| Output | Type | Description |
| --- | --- | --- |
| id | string | VPC ID |
| vpc | object | [VPC data source object](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/vpc) |
