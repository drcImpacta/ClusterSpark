resource "aws_key_pair" "emr_key_pair" {
  key_name   = "emr-key"
  public_key = "${file("./cluster-key.pub")}"
}
