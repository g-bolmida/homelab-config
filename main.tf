terraform {
  required_version = "~> 1.14"
  backend "s3" {
    bucket = "gbolmida-homelab-terraform"
    key    = "terraform.tfstate"
    region = "us-west-002"

    endpoints = {
      s3 = "https://s3.us-west-002.backblazeb2.com"
    }

    skip_credentials_validation = true
    skip_metadata_api_check     = true
    skip_region_validation      = true
    skip_requesting_account_id  = true
    skip_s3_checksum            = true
  }

  required_providers {
    portainer = {
      source  = "portainer/portainer"
      version = "1.21.0"
    }
    b2 = {
      source  = "Backblaze/b2"
      version = "0.13.2"
    }
    linode = {
      source  = "linode/linode"
      version = "3.7.0"
    }
  }
}

variable "portainer_endpoint" {
  type    = string
  default = "https://192.168.1.5:9443"
}

variable "skip_ssl_verify" {
  type    = bool
  default = true
}

variable "portainer_api_key" {}

provider "portainer" {
  endpoint        = var.portainer_endpoint
  api_key         = var.portainer_api_key
  skip_ssl_verify = var.skip_ssl_verify
}

variable "b2_application_key_id" {}
variable "b2_application_key" {}

provider "b2" {
  application_key_id = var.b2_application_key_id
  application_key    = var.b2_application_key
}

variable "linode_api_token" {}

provider "linode" {
  token = var.linode_api_token
}

data "portainer_environment" "local" {
  name = "local"
}

data "portainer_environment" "big_box" {
  name = "big-box"
}

output "local_environment_id" {
  value = data.portainer_environment.local.id
}

output "big_box_environment_id" {
  value = data.portainer_environment.big_box.id
}