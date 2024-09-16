provider "aws" {
  region = var.region
}

resource "aws_s3_bucket" "website_bucket" {
  bucket = var.bucket_name


  tags = {
    Name        = var.bucket_name
    Environment = "Dev"
  }
}

resource "aws_s3_bucket_website_configuration" "website" {
  bucket = aws_s3_bucket.website_bucket.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }

}

resource "aws_s3_bucket_public_access_block" "website_bucket" {
  bucket = aws_s3_bucket.website_bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "website_policy" {
  bucket = aws_s3_bucket.website_bucket.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource  = "${aws_s3_bucket.website_bucket.arn}/*"
      }
    ]
  })
}


locals {
  html_files = fileset("../../s3-website/", "*.html")
}

resource "aws_s3_bucket_object" "html_files" {
  for_each = local.html_files

  bucket       = aws_s3_bucket.website_bucket.bucket
  key          = each.value
  source       = "../../s3-website/${each.value}"
  content_type = "text/html"
}

resource "aws_s3_bucket_object" "jsonfile" {
  bucket       = aws_s3_bucket.website_bucket.bucket
  key          = "jsontest.json"
  source       = "../../lamdba-s3-events/jstontest.json"
  content_type = "application/json"

}
data "aws_region" "current" {}

