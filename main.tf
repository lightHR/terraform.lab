terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "3.0.2"
    }
  }
}

provider "docker" {}

resource "docker_image" "container_image" {
  name = "grafana/grafana"
}

resource "docker_container" "grafana_container" {
  count = 2
  name  = "grafana_container-${count.index}"
  image = docker_image.container_image.image_id
  ports {
    internal = var.int_port
    external = var.ext_port[count.index]
  }
}

output "public_ip" {
  value = [for x in docker_container.grafana_container : "${x.name} - ${x.network_data[0].ip_address}:${x.ports[0]["external"]}"]
}