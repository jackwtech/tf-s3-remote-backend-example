output "state-bucket" {
  value = aws_s3_bucket.terraform_state.bucket
}

output "state-lock-table" {
  value = aws_dynamodb_table.terraform_state_lock.name
}
