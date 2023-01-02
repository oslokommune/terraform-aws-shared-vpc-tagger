# tagger_config

Configure VPC and subnet tagging.

## Usage

```terraform
module "tagger_config" {
  source      = "git@github.com:oslokommune/terraform-vpc-tagger.git//modules/tagger_config?ref=v1"
  vpc_name    = "helsedata"
  team        = "informasjonsflyt"
  environment = "dev"
  tags        = local.common_tags
}
```

## Input

| Variable | Type | Description |
| --- | --- | --- |
| vpc_name | string | Name of the VPC |
| team | string | Name of team |
| environment | string | Name of environment |
| tags | map | Tags for all resources |

## Output

| Output | Type | Description |
| --- | --- | --- |
| vpc_name | string | Name of the VPC |
| team | string | Name of team |
| tags | map | Tags for all resources |
