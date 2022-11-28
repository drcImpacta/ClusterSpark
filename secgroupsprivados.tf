resource "aws_security_group" "slave_security_group" {
  name        = "slave_security_group"
  description = "Allow all internal traffic"
  vpc_id      = "${aws_vpc.main.id}"
  revoke_rules_on_delete = true
 
  # Allow communication between nodes in the VPC
  ingress {
    from_port   = "0"
    to_port     = "0"
    protocol    = "-1"
    self        = true
  }
 
  ingress {
      from_port   = "8443"
      to_port     = "8443"
      protocol    = "TCP"
  }
 
  egress {
    from_port   = "0"
    to_port     = "0"
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
 
  # Allow SSH traffic from VPN
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "TCP"
    cidr_blocks = ["123.123.0.0/16"]
  }
 
  lifecycle {
    ignore_changes = [ingress, egress]
  }
 
  tags = {
    name = "emr_test"
  }
}
