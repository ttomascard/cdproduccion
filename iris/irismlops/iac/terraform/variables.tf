variable "location" {
  type        = string
  description = "The location of the resource group"
}

variable "environment" {
  type        = string
  description = "The environment of the resource group"
}

variable "backend_image_name" {
  type        = string
  description = "The backend imagen name"
}

variable "frontend_imagen_name" {
  type        = string
  description = "The frontend imagen name"
}


variable "backend_function_imagen_name" {
  type        = string
  description = "The frontend imagen name"
}
