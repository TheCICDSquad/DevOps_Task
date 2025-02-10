# Create S3 Bucket and DynamoDB table to store state and state lock.
resource "aws_s3_bucket" "bucket" {
    bucket = var.bucket
}

resource "aws_dynamodb_table" "terraform-lock" {
    name           = var.table
    read_capacity  = 5
    write_capacity = 5
    hash_key       = "LockID"
    attribute {
        name = "LockID"
        type = "S"
    }

}

terraform {
  backend "s3" {
    bucket = "mybucket"
    key    = "admin/terraform.tf"
    region = "us-east-1"
  }
}
