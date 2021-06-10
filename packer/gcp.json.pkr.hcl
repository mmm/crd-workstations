#
# Copyright 2021 Google LLC
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

variable "gcp_project_id" {
  type    = string
  default = ""
}

locals {
  timestamp = regex_replace(timestamp(), "[- TZ:]", "")
}

source "googlecompute" "gcp_ubuntu_focal" {
  disk_size           = "100"
  machine_type        = "n2-standard-4"
  project_id          = "${var.gcp_project_id}"
  source_image_family = "ubuntu-2004-lts"
  ssh_username        = "packer"
  zone                = "us-central1-f"
}
source "googlecompute" "gcp_ubuntu_hirsute" {
  disk_size           = "100"
  machine_type        = "n2-standard-4"
  project_id          = "${var.gcp_project_id}"
  source_image_family = "ubuntu-2004-lts"
  ssh_username        = "packer"
  zone                = "us-central1-f"
}


build {
  name                = "kubuntu"

  source "source.googlecompute.gcp_ubuntu_focal" {
    image_family        = "ubuntu-2004-kubuntu-crd"
    image_name          = "ubuntu-2004-kubuntu-crd-${local.timestamp}"
    image_description   = "kubuntu crd workstation image"
  }
  #source "source.googlecompute.gcp_ubuntu_hirsute" {
    #image_family        = "ubuntu-2104-kubuntu-crd"
    #image_name          = "ubuntu-2104-kubuntu-crd-${local.timestamp}"
    #image_description   = "kubuntu crd workstation image"
  #}

  provisioner "shell" {
    execute_command = "chmod +x {{ .Path }}; sudo bash -c 'DESKTOP=kubuntu {{ .Vars }} {{ .Path }}'"
    scripts         = fileset(".", "scripts-ubuntu-20.04/*")
  }
}

build {
  name                = "cinnamon"

  source "source.googlecompute.gcp_ubuntu_focal" {
    image_family        = "ubuntu-2004-cinnamon-crd"
    image_name          = "ubuntu-2004-cinnamon-crd-${local.timestamp}"
    image_description   = "ubuntu cinnamon crd workstation image"
  }
  #source "source.googlecompute.gcp_ubuntu_hirsute" {
    #image_family        = "ubuntu-2104-cinnamon-crd"
    #image_name          = "ubuntu-2104-cinnamon-crd-${local.timestamp}"
    #image_description   = "ubuntu cinnamon crd workstation image"
  #}

  provisioner "shell" {
    execute_command = "chmod +x {{ .Path }}; sudo bash -c 'DESKTOP=cinnamon {{ .Vars }} {{ .Path }}'"
    scripts         = fileset(".", "scripts-ubuntu-20.04/*")
  }
}

build {
  name                = "plasma"

  source "source.googlecompute.gcp_ubuntu_focal" {
    image_family        = "ubuntu-2004-plasma-crd"
    image_name          = "ubuntu-2004-plasma-crd-${local.timestamp}"
    image_description   = "ubuntu plasma crd workstation image"
  }
  
  provisioner "shell" {
    execute_command = "chmod +x {{ .Path }}; sudo bash -c 'DESKTOP=plasma {{ .Vars }} {{ .Path }}'"
    scripts         = fileset(".", "scripts-ubuntu-20.04/*")
  }
}

build {
  name                = "xfce4"

  source "source.googlecompute.gcp_ubuntu_focal" {
    image_family        = "ubuntu-2004-xfce4-crd"
    image_name          = "ubuntu-2004-xfce4-crd-${local.timestamp}"
    image_description   = "ubuntu xfce4 crd workstation image"
  }

  provisioner "shell" {
    execute_command = "chmod +x {{ .Path }}; sudo bash -c 'DESKTOP=xfce4 {{ .Vars }} {{ .Path }}'"
    scripts         = fileset(".", "scripts-ubuntu-20.04/*")
  }
}
