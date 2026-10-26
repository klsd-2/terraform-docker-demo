terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
}

# Docker Desktop on Windows uses a named pipe.
# On Linux/macOS run: terraform apply -var="docker_host=unix:///var/run/docker.sock"
variable "docker_host" {
  description = "How Terraform connects to the Docker engine"
  type        = string
  default     = "npipe:////./pipe/docker_engine"
}

variable "host_port" {
  description = "Port on your computer that maps to nginx port 80"
  type        = number
  default     = 8080
}

provider "docker" {
  host = var.docker_host
}

# 1. Image (the container depends on this)
resource "docker_image" "nginx" {
  name         = "nginx:latest"
  keep_locally = false
}

# 2. Container (references the image, so Terraform creates the image first)
resource "docker_container" "nginx" {
  name  = "terraform-nginx"
  image = docker_image.nginx.image_id

  ports {
    internal = 80
    external = var.host_port
  }
}

output "container_name" {
  value = docker_container.nginx.name
}

output "app_url" {
  value = "http://localhost:${var.host_port}"
}
