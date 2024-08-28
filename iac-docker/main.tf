terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "3.0.2"
    }
  }
}

provider "docker" {}

resource "docker_container" "contenedorServWeb" {
  image = docker_image.flaskimage.image_id
  name  = "laboratorio"
  ports {
    internal = 8080
    external = 8081
  }
}

resource "docker_image" "flaskimage" {
  name = "laboratorio-flask"
  build {
    context = "../flask-docker"
    tag     = ["laboratorio-ds"]
  }
}