terraform {
  required_version = ">= 0.12.28"
   backend "local" {
    path = "terraform.tfstate"
  }
}

provider "aws" {
  version = "~> 2.68"
  region  = var.region
}

