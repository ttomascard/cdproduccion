# outputs.tf

output "bucket_arn" {
  value = aws_s3_bucket.data_bucket.arn
}
