locals {
  credentials_file_path = "/Users/Lee/.config/gcloud/application_default_credentials.json"
}

provider "google-beta" {
  credentials = "${file(local.credentials_file_path)}"
  project     = "${var.project_id}"
  region      = "${var.region}"
}
