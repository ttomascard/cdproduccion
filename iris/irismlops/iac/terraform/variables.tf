variable "location" {
  description = "The location of the resource group"
  type        = string
  
}
variable "environment" {
  description = "The environment of the resource group"
  type        = string
}

variable "backend_image_name" {
  description = "The name of the backend image"
  type        = string
}
