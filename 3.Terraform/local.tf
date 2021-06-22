locals {
  folders = yamldecode(file("${path.root}/folders.yaml"))
  projects = yamldecode(file("${path.root}/projects.yaml"))
}

output "get_foldeers" {
  value = local.folders
}