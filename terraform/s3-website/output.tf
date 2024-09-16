output "bucket_name" {
  value = aws_s3_bucket.website_bucket.bucket
}

output "website_url" {
  value = "http://${aws_s3_bucket.website_bucket.bucket}.s3-website.${var.region}.amazonaws.com"
}
