resource "portainer_stack" "overseerr" {
  name            = "overseerr"
  deployment_type = "standalone"
  method          = "file"
  endpoint_id     = data.portainer_environment.big_box.id
  stack_file_path = "./overseerr/docker-compose.yml"

  env {
    name  = "CONFIG_DIR"
    value = "/home/gbolmida/overseerr/config/"
  }
}

resource "portainer_stack" "flaresolverr" {
  name            = "flaresolverr"
  deployment_type = "standalone"
  method          = "file"
  endpoint_id     = data.portainer_environment.big_box.id
  stack_file_path = "./flaresolverr/docker-compose.yml"
}

resource "portainer_stack" "homeassistant" {
  name            = "homeassistant"
  deployment_type = "standalone"
  method          = "file"
  endpoint_id     = data.portainer_environment.local.id
  stack_file_path = "./homeassistant/docker-compose.yml"

  env {
    name  = "CONFIG_DIR"
    value = "/volume1/docker/home-assistant"
  }
  env {
    name  = "MEDIA_DIR"
    value = "/volume1/docker/ha-media"
  }
}

resource "portainer_stack" "qbittorrent" {
  name            = "qbittorrent"
  deployment_type = "standalone"
  method          = "file"
  endpoint_id     = data.portainer_environment.big_box.id
  stack_file_path = "./qbittorrent/docker-compose.yml"

  env {
    name  = "CONFIG_DIR"
    value = "/home/gbolmida/qbit/config/"
  }
}

resource "portainer_stack" "n8n" {
  name            = "n8n"
  deployment_type = "standalone"
  method          = "file"
  endpoint_id     = data.portainer_environment.big_box.id
  stack_file_path = "./n8n/docker-compose.yml"

  env {
    name  = "CONFIG_DIR"
    value = "/home/gbolmida/n8n"
  }
}

resource "portainer_stack" "big_box_backrest" {
  name            = "backrest"
  deployment_type = "standalone"
  method          = "file"
  endpoint_id     = data.portainer_environment.big_box.id
  stack_file_path = "./backrest/big-box-docker-compose.yml"
}

resource "portainer_stack" "plex" {
  name                      = "plex"
  deployment_type           = "standalone"
  method                    = "repository"
  endpoint_id               = data.portainer_environment.big_box.id
  repository_url            = "https://github.com/g-bolmida/homelab-config"
  repository_reference_name = "refs/heads/main"
  file_path_in_repository   = "./plex/big-box-docker-compose.yml"
  git_repository_authentication = true
  repository_git_credential_id = 6
}
