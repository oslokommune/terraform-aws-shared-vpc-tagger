# terraform-vpc-tagger

Tags VPCs and subnets that you did not create yourself (ie. shared VPCs)

## Usage

```terraform
module "tagger_config" {
  source      = "git@github.com:oslokommune/terraform-vpc-tagger.git//modules/tagger_config?ref=v1"
  vpc_name    = "helsedata"
  team        = "informasjonsflyt"
  environment = "dev"
  tags        = local.common_tags
}

module "shared_vpc" {
  source         = "git@github.com:oslokommune/terraform-vpc-tagger.git//modules/vpc_tagger?ref=v1"
  id             = "vpc-05086887c0451b882"
  tagger_config  = module.tagger_config
}

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

## Modules

 - [tagger_config](/modules/tagger_config/)
 - [vpc_tagger](/modules/vpc_tagger/)
 - [subnet_tagger](/modules/subnet_tagger/)
