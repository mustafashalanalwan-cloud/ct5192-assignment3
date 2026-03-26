provider "google" {
  project = var.project_id
  region  = var.region
  zone    = var.zone
}

resource "google_compute_instance" "vm_instance" {
  name         = "ct5192-assignment3-vm"
  machine_type = "e2-medium"
  zone         = var.zone

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-12"
    }
  }

  network_interface {
    network = "default"
    access_config {}
  }

  tags = ["ct5192-app"]
}

resource "google_compute_firewall" "allow_ports" {
  name    = "allow-ct5192-ports"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["22", "80", "4000", "5601", "9200"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["ct5192-app"]
}