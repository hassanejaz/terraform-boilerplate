resource "aws_s3_bucket" "b" {
  bucket = "b-test-hassan"
  acl    = "private"

  tags = {
    Name        = "b-test-hassan"
    Environment = "Dev"
  }
}

resource "aws_s3_bucket_public_access_block" "example" {
  bucket = aws_s3_bucket.b.id

  block_public_acls = true
  block_public_policy = true
  restrict_public_buckets = true
  ignore_public_acls = true
}