terraform {
  cloud {
    organization = "theshoetanfoundation"

    workspaces {
      name = "proxmox-k8s"
    }
  }
  required_providers {
    proxmox = {
      source = "Telmate/proxmox"
      version = "2.9.14"
    }
  }
}


provider "proxmox" {
  # Configuration options
  pm_api_url = local.tokens.pm_api_url
  pm_debug = true
  pm_api_token_id = local.tokens.token_id
  pm_api_token_secret = local.tokens.secret
  pm_tls_insecure     = true
}