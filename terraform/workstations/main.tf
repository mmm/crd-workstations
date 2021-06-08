#
# Copyright 2020 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

locals {
  master_os_image = "ubuntu-os-cloud/ubuntu-2004-lts"

  kubuntu_count = 1
  kubuntu_image = "mmm-goog-ad-eda-crd/ubuntu-2004-kubuntu-crd"
  xfce4_count = 1
  xfce4_image = "mmm-goog-ad-eda-crd/ubuntu-2004-xfce4-crd"
  cinnamon_count = 1
  cinnamon_image = "mmm-goog-ad-eda-crd/ubuntu-2004-cinnamon-crd"
  plasma_count = 1
  plasma_image = "mmm-goog-ad-eda-crd/ubuntu-2004-plasma-crd"
}

#data "terraform_remote_state" "storage" {
  #backend = "local"

  #config = {
    #path = "../storage/terraform.tfstate"
  #}
#}

resource "google_compute_instance" "workstation" {
  count        = 0
  name         = "workstation-${count.index}"
  machine_type = "n2-standard-4"
  zone         = var.zone

  tags = var.tags

  boot_disk {
    initialize_params {
      image = local.master_os_image

    }
  }
  scratch_disk {
    interface = "NVME" # Note: check if your OS image requires additional drivers or config to optimize NVME performance
  }
  metadata = {
    enable-oslogin = "TRUE"
  }

  network_interface {
    network = var.network
    access_config {} # Ephemeral IP
  }

  metadata_startup_script = templatefile("provision.sh.tmpl", {
    home_ip = "", #data.terraform_remote_state.storage.outputs.home-volume-ip-addresses[0],
    tools_ip = "", #data.terraform_remote_state.storage.outputs.tools-volume-ip-addresses[0],
  })

  service_account {
    #scopes = ["userinfo-email", "compute-ro", "storage-full"]
    scopes = ["cloud-platform"]  # too permissive for production
  }
}

resource "google_compute_instance" "bare-workstation" {
  count        = 0
  name         = "bare-workstation-${count.index}"
  machine_type = "n2-standard-2"
  zone         = var.zone

  tags = var.tags

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2004-lts"
    }
  }
  scratch_disk {
    interface = "NVME" # Note: check if your OS image requires additional drivers or config to optimize NVME performance
  }
  metadata = {
    enable-oslogin = "TRUE"
  }

  network_interface {
    network = var.network
    access_config {} # Ephemeral IP
  }

  metadata_startup_script = templatefile("provision.sh.tmpl", {
    home_ip = "", #data.terraform_remote_state.storage.outputs.home-volume-ip-addresses[0],
    tools_ip = "", #data.terraform_remote_state.storage.outputs.tools-volume-ip-addresses[0],
  })

  service_account {
    scopes = ["cloud-platform"]  # too permissive for production
  }
}

resource "google_compute_instance" "kubuntu_workstation" {
  count        = local.kubuntu_count
  name         = "kubuntu-workstation-${count.index}"
  machine_type = "n2-standard-4"
  zone         = var.zone

  tags = var.tags

  boot_disk {
    initialize_params {
      image = local.kubuntu_image

    }
  }
  metadata = {
    enable-oslogin = "TRUE"
  }

  network_interface {
    network = var.network
    access_config {} # Ephemeral IP
  }

  metadata_startup_script = templatefile("provision.sh.tmpl", {
    home_ip = "", #data.terraform_remote_state.storage.outputs.home-volume-ip-addresses[0],
    tools_ip = "", #data.terraform_remote_state.storage.outputs.tools-volume-ip-addresses[0],
  })

  service_account {
    #scopes = ["userinfo-email", "compute-ro", "storage-full"]
    scopes = ["cloud-platform"]  # too permissive for production
  }
}

resource "google_compute_instance" "cinnamon_workstation" {
  count        = local.cinnamon_count
  name         = "cinnamon-workstation-${count.index}"
  machine_type = "n2-standard-4"
  zone         = var.zone

  tags = var.tags

  boot_disk {
    initialize_params {
      image = local.cinnamon_image

    }
  }
  metadata = {
    enable-oslogin = "TRUE"
  }

  network_interface {
    network = var.network
    access_config {} # Ephemeral IP
  }

  metadata_startup_script = templatefile("provision.sh.tmpl", {
    home_ip = "", #data.terraform_remote_state.storage.outputs.home-volume-ip-addresses[0],
    tools_ip = "", #data.terraform_remote_state.storage.outputs.tools-volume-ip-addresses[0],
  })

  service_account {
    #scopes = ["userinfo-email", "compute-ro", "storage-full"]
    scopes = ["cloud-platform"]  # too permissive for production
  }
}

resource "google_compute_instance" "plasma_workstation" {
  count        = local.plasma_count
  name         = "plasma-workstation-${count.index}"
  machine_type = "n2-standard-4"
  zone         = var.zone

  tags = var.tags

  boot_disk {
    initialize_params {
      image = local.plasma_image

    }
  }
  metadata = {
    enable-oslogin = "TRUE"
  }

  network_interface {
    network = var.network
    access_config {} # Ephemeral IP
  }

  metadata_startup_script = templatefile("provision.sh.tmpl", {
    home_ip = "", #data.terraform_remote_state.storage.outputs.home-volume-ip-addresses[0],
    tools_ip = "", #data.terraform_remote_state.storage.outputs.tools-volume-ip-addresses[0],
  })

  service_account {
    #scopes = ["userinfo-email", "compute-ro", "storage-full"]
    scopes = ["cloud-platform"]  # too permissive for production
  }
}

resource "google_compute_instance" "xfce4_workstation" {
  count        = local.xfce4_count
  name         = "xfce4-workstation-${count.index}"
  machine_type = "n2-standard-4"
  zone         = var.zone

  tags = var.tags

  boot_disk {
    initialize_params {
      image = local.xfce4_image

    }
  }
  metadata = {
    enable-oslogin = "TRUE"
  }

  network_interface {
    network = var.network
    access_config {} # Ephemeral IP
  }

  metadata_startup_script = templatefile("provision.sh.tmpl", {
    home_ip = "", #data.terraform_remote_state.storage.outputs.home-volume-ip-addresses[0],
    tools_ip = "", #data.terraform_remote_state.storage.outputs.tools-volume-ip-addresses[0],
  })

  service_account {
    #scopes = ["userinfo-email", "compute-ro", "storage-full"]
    scopes = ["cloud-platform"]  # too permissive for production
  }
}
