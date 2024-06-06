# tf-s3-remote-backend-example

An example project of setting up AWS S3 as the remote backend for Terraform project

## Step 1 - create S3 Bucket and DynamoDB Table using Terraform

Create `aws_s3_bucket` to store state file, and `aws_dynamodb_table` for the state locking.

Note that the bucket should be private and encrypted properly. By default use SSE-S3 for cost saving for this example project.
In production, you should encrypt the bucket and objects with KMS, as well as enabling bucket versioning, etc.

Run `terraform apply` to create these two resources and the states are stored in the local state file `terraform.tfstate`

## Step 2 - apply the Bucket & DynamoDB as the remote backend

After Terraform updates successfully, you should get the below outputs:

```sh
Outputs:

state-bucket = "tf-s3-backend-tfstate-1234567890"
state-lock-table = "tf-s3-backend-tfstate-lock"
```

Create a file called `backend.local` and use these output values, similar to below:

```
bucket="tf-s3-backend-tfstate-1234567890"
key="terraform.tfstate"
dynamodb_table="tf-s3-backend-tfstate-lock"
profile="dev"
region="us-east-1"
```

Create a file called `backend.tf` and use S3 as the backend. Don't need to supply the config.
We can pass the `backend.local` when re-init Terraform project.

```tf
terraform {
  backend "s3" {}
}
```

Run below command, enter "yes" when prompted to migrate local state to S3 backend.

```sh
terraform init -backend-config="backend.local"
```

Note that the Terraform state has been migrated from local state file to S3.

And from here you can continue on the Terraform project to manage your cloud resources.

## Additional note - avoid deletion of S3 Bucket and DynamoDB Table

You should apply the lifecycle to avoid resource deletion. You don't want to lose your state file!

```
lifecycle {
  prevent_destroy = true
}
```
