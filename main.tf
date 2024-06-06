resource "aws_s3_bucket" "terraform_state" {
  bucket_prefix = lower("${var.project}-tfstate-")
}

resource "aws_dynamodb_table" "terraform_state_lock" {
  name         = "${var.project}-tfstate-lock"
  hash_key     = "LockID"
  billing_mode = "PAY_PER_REQUEST"

  attribute {
    name = "LockID"
    type = "S"
  }
}
