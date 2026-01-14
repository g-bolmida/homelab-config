variable "linode_root_password" {}

resource "linode_instance" "teleport-server" {
  label              = "teleport-server"
  tags               = ["teleport", "terraform"]
  region             = "ca-central"
  type               = "g6-nanode-1"
  image              = "linode/rocky10"
  maintenance_policy = "linode/migrate"
  disk_encryption    = "enabled"
  authorized_keys    = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAID2zdP0UYFiDud06c3t6eCcyTOeiTKLWg+JspBZDXv+8 gbolmida@Georges-MacBook-Air.local"]
  root_pass          = var.linode_root_password
}

resource "linode_firewall" "teleport-firewall" {
  label = "teleport-firewall"

  inbound_policy  = "DROP"
  outbound_policy = "ACCEPT"

  inbound {
    label    = "accept-tp-service"
    action   = "ACCEPT"
    protocol = "TCP"
    ports    = "443"
    ipv4     = ["0.0.0.0/0"]
    ipv6     = ["::/0"]
  }

  inbound {
    label    = "accept-inbound-SSH"
    action   = "ACCEPT"
    protocol = "TCP"
    ports    = "22"
    ipv4     = ["216.196.162.210/32"]
  }

  linodes = [linode_instance.teleport-server.id]
}
