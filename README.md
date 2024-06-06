# tf-s3-remote-backend-example

An example project of setting up AWS S3 as the remote backend for Terraform project

## Step 1 - create S3 Bucket and DynamoDB Table using Terraform

Create `aws_s3_bucket` to store state file, and `aws_dynamodb_table` for the state locking.

Note that the bucket should be private and encrypted properly. By default use SSE-S3 for cost saving for this example project.
In production, you should encrypt the bucket and objects with KMS, as well as enabling bucket versioning, etc.

Run `terraform apply` to create these two resources and the states are stored in the local state file `terraform.tfstate`
