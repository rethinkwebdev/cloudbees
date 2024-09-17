data "github_repository" "repo" {
  name = "cloudbees"
}

resource "github_repository_deploy_key" "deploy_key" {
  title      = "${var.env} - Flux CD Deploy Key"
  repository = data.github_repository.repo.name
  key        = data.onepassword_item.deploy_key.public_key
  read_only  = false
}

data "onepassword_vault" "vault" {
  name = "Kubernetes"
}

data "onepassword_item" "deploy_key" {
  vault = data.onepassword_vault.vault.name
  title = "Github Cloudbees ${var.env} Deploy Key"
}

# Bootstrap 

resource "flux_bootstrap_git" "this" {
  depends_on         = [github_repository_deploy_key.deploy_key, module.eks]
  embedded_manifests = true
  path               = "kubernetes/envs/${var.env}"
}
