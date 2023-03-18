terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.51.0"
    }
  }
}

provider "google" {
    credentials = file(".terraform/init64-key.json") # Specify the path to your cloud account key

    project = "init64"
    region  = "europe-west2"
    zone    = "europe-west2-c"
}

resource "google_compute_instance" "vm_instance" {
    name            = "init64-stage"
    machine_type    = "e2-micro"
    tags            = ["stage", "web"]

    boot_disk {
        initialize_params {
          image = "rocky-linux-9"
        }
    }

    metadata = {
        ssh-keys = "admin:${file("~/.ssh/id_rsa.pub")}" # Specify the path to your public key
    }

    network_interface {
      network = "default"

      access_config {
      }
    }
}