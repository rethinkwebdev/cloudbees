terraform {

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.47.0"
    }

    random = {
      source  = "hashicorp/random"
      version = "~> 3.6.1"
    }

    tls = {
      source  = "hashicorp/tls"
      version = "~> 4.0.5"
    }

    cloudinit = {
      source  = "hashicorp/cloudinit"
      version = "~> 2.3.4"
    }
    flux = {
      source = "fluxcd/flux"
      version = "1.3.0"
    }
    github = {
      source = "integrations/github"
      version = ">= 6.1"
    }
    onepassword = {
      source = "1Password/onepassword"
      version = ">= 2.1.0"
    }
  }

  required_version = "~> 1.3"
}

provider "onepassword" {
  account = "my.1password.com"
}

provider "github" {
  
}

provider "aws" {
  region = var.region
}

provider "flux" {
  kubernetes = {
    host                   = module.eks.cluster_endpoint
    cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
    exec = {
      api_version = "client.authentication.k8s.io/v1beta1"
      args        = ["eks", "get-token", "--cluster-name", module.eks.cluster_name]
      command     = "aws"
    }
  }
  git = {
    url = "ssh://git@github.com/rethinkwebdev/cloudbees.git"
    ssh = {
      username = "git"
      private_key = data.onepassword_item.deploy_key.private_key
    }
  }
}