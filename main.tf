locals {
  region  = "us-central1"
  zone    = "us-central1-c"
  project  = "project-test-270001"
}

# Specify the GCP Provider
provider "google" {
  project  = local.project
  region   = local.region
  zone     = local.zone
}

# local-exec for building the docker image and push it from terraform
resource "null_resource" "building_docker_image" {
  triggers = {
    image_id = var.image_id
  }
  provisioner "local-exec" {
    command = <<EOF
      docker build -t kongdbless:latest .
    EOF
  }
}
