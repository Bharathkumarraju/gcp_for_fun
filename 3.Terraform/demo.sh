bharathdasaraju@MacBook-Pro 3.Terraform (main) $ terraform init
Initializing modules...

Initializing the backend...

Initializing provider plugins...
- Reusing previous version of hashicorp/google from the dependency lock file
- Using previously-installed hashicorp/google v3.73.0

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.
bharathdasaraju@MacBook-Pro 3.Terraform (main) $ clear
bharathdasaraju@MacBook-Pro 3.Terraform (main) $ terraform plan

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # module.folders["dev"].google_folder.folders["bharath-dev"] will be created
  + resource "google_folder" "folders" {
      + create_time     = (known after apply)
      + display_name    = "bharath-dev"
      + folder_id       = (known after apply)
      + id              = (known after apply)
      + lifecycle_state = (known after apply)
      + name            = (known after apply)
      + parent          = "organizations/429874978957"
    }

  # module.folders["dev"].google_folder_iam_binding.owners["bharath-dev-roles/compute.networkAdmin"] will be created
  + resource "google_folder_iam_binding" "owners" {
      + etag    = (known after apply)
      + folder  = (known after apply)
      + id      = (known after apply)
      + members = [
          + "group:gcp-admins@bharathkumaraju.com",
        ]
      + role    = "roles/compute.networkAdmin"
    }

  # module.folders["dev"].google_folder_iam_binding.owners["bharath-dev-roles/owner"] will be created
  + resource "google_folder_iam_binding" "owners" {
      + etag    = (known after apply)
      + folder  = (known after apply)
      + id      = (known after apply)
      + members = [
          + "group:gcp-admins@bharathkumaraju.com",
        ]
      + role    = "roles/owner"
    }

  # module.folders["dev"].google_folder_iam_binding.owners["bharath-dev-roles/resourcemanager.folderViewer"] will be created
  + resource "google_folder_iam_binding" "owners" {
      + etag    = (known after apply)
      + folder  = (known after apply)
      + id      = (known after apply)
      + members = [
          + "group:gcp-admins@bharathkumaraju.com",
        ]
      + role    = "roles/resourcemanager.folderViewer"
    }

  # module.folders["dev"].google_folder_iam_binding.owners["bharath-dev-roles/resourcemanager.projectCreator"] will be created
  + resource "google_folder_iam_binding" "owners" {
      + etag    = (known after apply)
      + folder  = (known after apply)
      + id      = (known after apply)
      + members = [
          + "group:gcp-admins@bharathkumaraju.com",
        ]
      + role    = "roles/resourcemanager.projectCreator"
    }

  # module.folders["prod"].google_folder.folders["bharath-prod"] will be created
  + resource "google_folder" "folders" {
      + create_time     = (known after apply)
      + display_name    = "bharath-prod"
      + folder_id       = (known after apply)
      + id              = (known after apply)
      + lifecycle_state = (known after apply)
      + name            = (known after apply)
      + parent          = "organizations/429874978957"
    }

  # module.folders["prod"].google_folder_iam_binding.owners["bharath-prod-roles/compute.networkAdmin"] will be created
  + resource "google_folder_iam_binding" "owners" {
      + etag    = (known after apply)
      + folder  = (known after apply)
      + id      = (known after apply)
      + members = [
          + "group:gcp-admins@bharathkumaraju.com",
        ]
      + role    = "roles/compute.networkAdmin"
    }

  # module.folders["prod"].google_folder_iam_binding.owners["bharath-prod-roles/owner"] will be created
  + resource "google_folder_iam_binding" "owners" {
      + etag    = (known after apply)
      + folder  = (known after apply)
      + id      = (known after apply)
      + members = [
          + "group:gcp-admins@bharathkumaraju.com",
        ]
      + role    = "roles/owner"
    }

  # module.folders["prod"].google_folder_iam_binding.owners["bharath-prod-roles/resourcemanager.folderViewer"] will be created
  + resource "google_folder_iam_binding" "owners" {
      + etag    = (known after apply)
      + folder  = (known after apply)
      + id      = (known after apply)
      + members = [
          + "group:gcp-admins@bharathkumaraju.com",
        ]
      + role    = "roles/resourcemanager.folderViewer"
    }

  # module.folders["prod"].google_folder_iam_binding.owners["bharath-prod-roles/resourcemanager.projectCreator"] will be created
  + resource "google_folder_iam_binding" "owners" {
      + etag    = (known after apply)
      + folder  = (known after apply)
      + id      = (known after apply)
      + members = [
          + "group:gcp-admins@bharathkumaraju.com",
        ]
      + role    = "roles/resourcemanager.projectCreator"
    }

Plan: 10 to add, 0 to change, 0 to destroy.

Changes to Outputs:
  ~ get_foldeers = {
      ~ dev  = {
          ~ parent = "bharathkumaraju.com/429874978957" -> "organizations/429874978957"
            # (1 unchanged element hidden)
        }
      ~ prod = {
          ~ parent = "bharathkumaraju.com/429874978957" -> "organizations/429874978957"
            # (1 unchanged element hidden)
        }
    }

─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────

Note: You didn't use the -out option to save this plan, so Terraform can't guarantee to take exactly these actions if you run "terraform apply" now.
bharathdasaraju@MacBook-Pro 3.Terraform (main) $ terraform apply -auto-approve

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # module.folders["dev"].google_folder.folders["bharath-dev"] will be created
  + resource "google_folder" "folders" {
      + create_time     = (known after apply)
      + display_name    = "bharath-dev"
      + folder_id       = (known after apply)
      + id              = (known after apply)
      + lifecycle_state = (known after apply)
      + name            = (known after apply)
      + parent          = "organizations/429874978957"
    }

  # module.folders["dev"].google_folder_iam_binding.owners["bharath-dev-roles/compute.networkAdmin"] will be created
  + resource "google_folder_iam_binding" "owners" {
      + etag    = (known after apply)
      + folder  = (known after apply)
      + id      = (known after apply)
      + members = [
          + "group:gcp-admins@bharathkumaraju.com",
        ]
      + role    = "roles/compute.networkAdmin"
    }

  # module.folders["dev"].google_folder_iam_binding.owners["bharath-dev-roles/owner"] will be created
  + resource "google_folder_iam_binding" "owners" {
      + etag    = (known after apply)
      + folder  = (known after apply)
      + id      = (known after apply)
      + members = [
          + "group:gcp-admins@bharathkumaraju.com",
        ]
      + role    = "roles/owner"
    }

  # module.folders["dev"].google_folder_iam_binding.owners["bharath-dev-roles/resourcemanager.folderViewer"] will be created
  + resource "google_folder_iam_binding" "owners" {
      + etag    = (known after apply)
      + folder  = (known after apply)
      + id      = (known after apply)
      + members = [
          + "group:gcp-admins@bharathkumaraju.com",
        ]
      + role    = "roles/resourcemanager.folderViewer"
    }

  # module.folders["dev"].google_folder_iam_binding.owners["bharath-dev-roles/resourcemanager.projectCreator"] will be created
  + resource "google_folder_iam_binding" "owners" {
      + etag    = (known after apply)
      + folder  = (known after apply)
      + id      = (known after apply)
      + members = [
          + "group:gcp-admins@bharathkumaraju.com",
        ]
      + role    = "roles/resourcemanager.projectCreator"
    }

  # module.folders["prod"].google_folder.folders["bharath-prod"] will be created
  + resource "google_folder" "folders" {
      + create_time     = (known after apply)
      + display_name    = "bharath-prod"
      + folder_id       = (known after apply)
      + id              = (known after apply)
      + lifecycle_state = (known after apply)
      + name            = (known after apply)
      + parent          = "organizations/429874978957"
    }

  # module.folders["prod"].google_folder_iam_binding.owners["bharath-prod-roles/compute.networkAdmin"] will be created
  + resource "google_folder_iam_binding" "owners" {
      + etag    = (known after apply)
      + folder  = (known after apply)
      + id      = (known after apply)
      + members = [
          + "group:gcp-admins@bharathkumaraju.com",
        ]
      + role    = "roles/compute.networkAdmin"
    }

  # module.folders["prod"].google_folder_iam_binding.owners["bharath-prod-roles/owner"] will be created
  + resource "google_folder_iam_binding" "owners" {
      + etag    = (known after apply)
      + folder  = (known after apply)
      + id      = (known after apply)
      + members = [
          + "group:gcp-admins@bharathkumaraju.com",
        ]
      + role    = "roles/owner"
    }

  # module.folders["prod"].google_folder_iam_binding.owners["bharath-prod-roles/resourcemanager.folderViewer"] will be created
  + resource "google_folder_iam_binding" "owners" {
      + etag    = (known after apply)
      + folder  = (known after apply)
      + id      = (known after apply)
      + members = [
          + "group:gcp-admins@bharathkumaraju.com",
        ]
      + role    = "roles/resourcemanager.folderViewer"
    }

  # module.folders["prod"].google_folder_iam_binding.owners["bharath-prod-roles/resourcemanager.projectCreator"] will be created
  + resource "google_folder_iam_binding" "owners" {
      + etag    = (known after apply)
      + folder  = (known after apply)
      + id      = (known after apply)
      + members = [
          + "group:gcp-admins@bharathkumaraju.com",
        ]
      + role    = "roles/resourcemanager.projectCreator"
    }

Plan: 10 to add, 0 to change, 0 to destroy.

Changes to Outputs:
  ~ get_foldeers = {
      ~ dev  = {
          ~ parent = "bharathkumaraju.com/429874978957" -> "organizations/429874978957"
            # (1 unchanged element hidden)
        }
      ~ prod = {
          ~ parent = "bharathkumaraju.com/429874978957" -> "organizations/429874978957"
            # (1 unchanged element hidden)
        }
    }
module.folders["dev"].google_folder.folders["bharath-dev"]: Creating...
module.folders["prod"].google_folder.folders["bharath-prod"]: Creating...
module.folders["dev"].google_folder.folders["bharath-dev"]: Still creating... [10s elapsed]
module.folders["prod"].google_folder.folders["bharath-prod"]: Still creating... [10s elapsed]
module.folders["dev"].google_folder.folders["bharath-dev"]: Creation complete after 14s [id=folders/820328262021]
module.folders["dev"].google_folder_iam_binding.owners["bharath-dev-roles/owner"]: Creating...
module.folders["dev"].google_folder_iam_binding.owners["bharath-dev-roles/resourcemanager.folderViewer"]: Creating...
module.folders["dev"].google_folder_iam_binding.owners["bharath-dev-roles/compute.networkAdmin"]: Creating...
module.folders["dev"].google_folder_iam_binding.owners["bharath-dev-roles/resourcemanager.projectCreator"]: Creating...
module.folders["prod"].google_folder.folders["bharath-prod"]: Creation complete after 15s [id=folders/15791477849]
module.folders["prod"].google_folder_iam_binding.owners["bharath-prod-roles/compute.networkAdmin"]: Creating...
module.folders["prod"].google_folder_iam_binding.owners["bharath-prod-roles/resourcemanager.folderViewer"]: Creating...
module.folders["prod"].google_folder_iam_binding.owners["bharath-prod-roles/resourcemanager.projectCreator"]: Creating...
module.folders["prod"].google_folder_iam_binding.owners["bharath-prod-roles/owner"]: Creating...
module.folders["dev"].google_folder_iam_binding.owners["bharath-dev-roles/resourcemanager.folderViewer"]: Still creating... [10s elapsed]
module.folders["dev"].google_folder_iam_binding.owners["bharath-dev-roles/owner"]: Still creating... [10s elapsed]
module.folders["dev"].google_folder_iam_binding.owners["bharath-dev-roles/compute.networkAdmin"]: Still creating... [10s elapsed]
module.folders["dev"].google_folder_iam_binding.owners["bharath-dev-roles/resourcemanager.projectCreator"]: Still creating... [10s elapsed]
module.folders["dev"].google_folder_iam_binding.owners["bharath-dev-roles/resourcemanager.projectCreator"]: Creation complete after 10s [id=folders/820328262021/roles/resourcemanager.projectCreator]
module.folders["prod"].google_folder_iam_binding.owners["bharath-prod-roles/owner"]: Still creating... [10s elapsed]
module.folders["prod"].google_folder_iam_binding.owners["bharath-prod-roles/resourcemanager.folderViewer"]: Still creating... [10s elapsed]
module.folders["prod"].google_folder_iam_binding.owners["bharath-prod-roles/resourcemanager.projectCreator"]: Still creating... [10s elapsed]
module.folders["prod"].google_folder_iam_binding.owners["bharath-prod-roles/compute.networkAdmin"]: Still creating... [10s elapsed]
module.folders["dev"].google_folder_iam_binding.owners["bharath-dev-roles/resourcemanager.folderViewer"]: Still creating... [20s elapsed]
module.folders["dev"].google_folder_iam_binding.owners["bharath-dev-roles/compute.networkAdmin"]: Still creating... [20s elapsed]
module.folders["dev"].google_folder_iam_binding.owners["bharath-dev-roles/owner"]: Still creating... [20s elapsed]
module.folders["prod"].google_folder_iam_binding.owners["bharath-prod-roles/owner"]: Still creating... [20s elapsed]
module.folders["prod"].google_folder_iam_binding.owners["bharath-prod-roles/compute.networkAdmin"]: Still creating... [20s elapsed]
module.folders["prod"].google_folder_iam_binding.owners["bharath-prod-roles/resourcemanager.projectCreator"]: Still creating... [20s elapsed]
module.folders["prod"].google_folder_iam_binding.owners["bharath-prod-roles/resourcemanager.folderViewer"]: Still creating... [20s elapsed]
module.folders["prod"].google_folder_iam_binding.owners["bharath-prod-roles/compute.networkAdmin"]: Creation complete after 28s [id=folders/15791477849/roles/compute.networkAdmin]
module.folders["prod"].google_folder_iam_binding.owners["bharath-prod-roles/resourcemanager.projectCreator"]: Creation complete after 29s [id=folders/15791477849/roles/resourcemanager.projectCreator]
module.folders["dev"].google_folder_iam_binding.owners["bharath-dev-roles/compute.networkAdmin"]: Still creating... [30s elapsed]
module.folders["dev"].google_folder_iam_binding.owners["bharath-dev-roles/resourcemanager.folderViewer"]: Still creating... [30s elapsed]
module.folders["dev"].google_folder_iam_binding.owners["bharath-dev-roles/owner"]: Still creating... [30s elapsed]
module.folders["prod"].google_folder_iam_binding.owners["bharath-prod-roles/resourcemanager.folderViewer"]: Creation complete after 29s [id=folders/15791477849/roles/resourcemanager.folderViewer]
module.folders["dev"].google_folder_iam_binding.owners["bharath-dev-roles/compute.networkAdmin"]: Creation complete after 30s [id=folders/820328262021/roles/compute.networkAdmin]
module.folders["dev"].google_folder_iam_binding.owners["bharath-dev-roles/resourcemanager.folderViewer"]: Creation complete after 31s [id=folders/820328262021/roles/resourcemanager.folderViewer]
module.folders["prod"].google_folder_iam_binding.owners["bharath-prod-roles/owner"]: Creation complete after 30s [id=folders/15791477849/roles/owner]
module.folders["dev"].google_folder_iam_binding.owners["bharath-dev-roles/owner"]: Creation complete after 31s [id=folders/820328262021/roles/owner]

Apply complete! Resources: 10 added, 0 changed, 0 destroyed.

Outputs:

get_foldeers = {
  "dev" = {
    "name" = "bharath-dev"
    "parent" = "organizations/429874978957"
  }
  "prod" = {
    "name" = "bharath-prod"
    "parent" = "organizations/429874978957"
  }
}
bharathdasaraju@MacBook-Pro 3.Terraform (main) $