packer {
  required_plugins {
    amazon = {
      version = ">= 0.0.2"
      source  = "github.com/hashicorp/qemu"
    }
  }
}


source "qemu" "qemu_base_image" {
  disk_image        = true
  iso_url           = "http://mirror.raystedman.net/centos/6/isos/x86_64/CentOS-6.9-x86_64-minimal.iso"
  iso_checksum      = "none"
  output_directory  = "output_centos_tdhtest"
  shutdown_command  = "echo 'packer' | sudo -S shutdown -P now"
  disk_size         = "8G"
  format            = "qcow2"
  accelerator       = "kvm"
  #http_directory    = "path/to/httpdir"
  ssh_username      = "root"
  ssh_password      = "openEuler12#$"
  ssh_timeout       = "20m"
  vm_name           = "openeulervm"
  net_device        = "virtio-net"
  disk_interface    = "virtio"
  boot_wait         = "10s"
  #boot_command      = ["<tab> text ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/centos6-ks.cfg<enter><wait>"]
}

build {
  sources = ["source.qemu.qemu_base_image"]

  provisioner "shell" {
    script = ["../../scripts/openeuler-install-cloudinit"]
  }
}

