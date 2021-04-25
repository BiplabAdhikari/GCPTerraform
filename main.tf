// Configure the Google Cloud provider
provider "google" {
 credentials = file("terraformConfig.json")
 project     = "gcpdevops1243852"
 region      = "asia-south1"
}

resource "random_password" "password" {
  length           = 12
  special          = true
  override_special = "_%@"
}

data "google_compute_zones" "available" {
  project = "gcpdevops1243852"
}

data "template_file" "install_tomcat" {
  template = file("${path.module}/install_tomcat.sh")
  vars = {
    tomcat_User          = "tomcat_user"
    tomcat_Group         = "tomcat_group"
    tomcat_AdminUser     = "tomcat_admin"
    tomcat_AdminPassword = random_password.password.result
  }
}

resource "google_compute_instance" "compute-jenkins" {
  name         = "compute-jenkins"
  machine_type = "e2-small"
  zone         = data.google_compute_zones.available.names[0]

  boot_disk {
    initialize_params {
      image = "ubuntu-1604-lts"
    }
  }

  metadata_startup_script   = file("./install_jenkins.sh")
  allow_stopping_for_update = true

  network_interface {
    network = "default"
    access_config {}
  }

  tags = ["http-server"]
}

resource "google_compute_instance" "compute-application" {
  name         = "compute-application"
  machine_type = "f1-micro"
  zone         = data.google_compute_zones.available.names[0]

  boot_disk {
    initialize_params {
      image = "ubuntu-1604-lts"
    }
  }

  metadata_startup_script = data.template_file.install_tomcat.rendered

  network_interface {
    network = "default"
    access_config {}
  }

  tags = ["http-server"]
}

resource "google_compute_instance" "compute-development" {
  name         = "compute-development"
  machine_type = "f1-micro"
  zone         = data.google_compute_zones.available.names[0]

  boot_disk {
    initialize_params {
      image = "ubuntu-1604-lts"
    }
  }

  metadata_startup_script = file("./install_git.sh")

  network_interface {
    network = "default"
    access_config {}
  }

  tags = ["http-server"]
}

resource "google_compute_instance" "compute-docker" {
  name         = "compute-docker"
  machine_type = "e2-micro"
  zone         = data.google_compute_zones.available.names[0]

  boot_disk {
    initialize_params {
      image = "ubuntu-1604-lts"
    }
  }

  metadata_startup_script = file("./install_docker.sh")

  network_interface {
    network = "default"
    access_config {}
  }

  tags = ["http-server"]
}

resource "google_compute_firewall" "default" {
  name    = "firewall-allow-http-terraform"
  network = "default"


  allow {
    protocol = "tcp"
    ports    = ["80", "8080"]
  }

  source_ranges = ["0.0.0.0/0"]

  target_tags   = ["http-server"]
}
