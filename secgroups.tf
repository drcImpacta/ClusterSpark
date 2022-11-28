resource "aws_security_group" "master_security_group" {
  name        = "master_security_group"
  description = "Allow inbound traffic from VPN"
  vpc_id      = "${aws_vpc.main.id}"
 
  # Avoid circular dependencies stopping the destruction of the cluster
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
 
  #### Expose web interfaces to VPN
 
  # Yarn
  ingress {
    from_port   = 8088
    to_port     = 8088
    protocol    = "TCP"
    cidr_blocks = ["123.123.0.0/16"]
  }
 
  # Spark History
  ingress {
      from_port   = 18080
      to_port     = 18080
      protocol    = "TCP"
      cidr_blocks = ["123.123.0.0/16"]
    }
 
  # Zeppelin
  ingress {
      from_port   = 8890
      to_port     = 8890
      protocol    = "TCP"
      cidr_blocks = ["123.123.0.0/16"]
  }
 
  # Spark UI
  ingress {
      from_port   = 4040
      to_port     = 4040
      protocol    = "TCP"
      cidr_blocks = ["123.123.0.0/16"]
  }
 
  # Ganglia
  ingress {
      from_port   = 80
      to_port     = 80
      protocol    = "TCP"
      cidr_blocks = ["123.123.0.0/16"]
  }
 
  # Hue
  ingress {
      from_port   = 8888
      to_port     = 8888
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
