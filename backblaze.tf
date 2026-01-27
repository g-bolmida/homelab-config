resource "b2_bucket" "teleport-auth-backup-bucket" {
  bucket_name = "gbolmida-teleport-auth-backup"
  bucket_type = "allPrivate"
  bucket_info = {
    "purpose" = "backrest teleport backups for auth/proxy node"
  }
  default_server_side_encryption {
    algorithm = "AES256"
    mode      = "SSE-B2"
  }
}

resource "b2_bucket" "synology-backup-bucket" {
  bucket_name = "gbolmida-synology-backup"
  bucket_type = "allPrivate"
  bucket_info = {
    "purpose" = "backrest synology backups"
  }
  default_server_side_encryption {
    algorithm = "AES256"
    mode      = "SSE-B2"
  }
}

resource "b2_bucket" "big-box-backup-bucket" {
  bucket_name = "gbolmida-big-box-backup"
  bucket_type = "allPrivate"
  bucket_info = {
    "purpose" = "backrest big box backups"
  }
  default_server_side_encryption {
    algorithm = "AES256"
    mode      = "SSE-B2"
  }
}

resource "b2_bucket" "gbolmida-gitea-storage" {
  bucket_name = "gbolmida-gitea-storage"
  bucket_type = "allPrivate"
  bucket_info = {
    "purpose" = "gitea backend storage"
  }
  default_server_side_encryption {
    algorithm = "AES256"
    mode      = "SSE-B2"
  }
}
