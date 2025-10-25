terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
  required_version = ">= 1.6.0"
}

# Docker Desktop on Windows listens on a named pipe
provider "docker" {
  host = "npipe:////./pipe/docker_engine"
}

# Pull the nginx image
resource "docker_image" "nginx" {
  name         = "nginx:latest"
  keep_locally = false
}

# Run nginx and map localhost:8080 -> container:80
resource "docker_container" "nginx" {
  name  = "tf-nginx"
  image = docker_image.nginx.image_id
  ports {
    internal = 80
    external = 8080
  }
}
