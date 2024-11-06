# main.tf

provider "aws" {
  region = var.aws_region
}

resource "aws_s3_bucket" "data_bucket" {
  bucket = var.bucket_name
  acl    = "private"
}

output "bucket_name" {
  value = aws_s3_bucket.data_bucket.id
}
