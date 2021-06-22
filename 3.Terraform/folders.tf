module "folders" {
  source     = "terraform-google-modules/folders/google"
  version    = "~> 3.0"

  for_each   = local.folders

  parent     = each.value.parent

  names = [each.value.name]

  set_roles = true

  all_folder_admins = [
    "group:gcp-admins@bharathkumaraju.com",
  ]
}