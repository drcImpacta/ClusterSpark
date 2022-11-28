resource "aws_s3_bucket_versioning" "logging_bucket" {
  bucket = "emr-logging-bucket"
 
  versioning_configuration {
    status = "Enabled"
  }
}
