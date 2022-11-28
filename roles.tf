resource "aws_iam_role" "spark_cluster_iam_emr_service_role" {
    name = "spark_cluster_emr_service_role"
 
    assume_role_policy = jsonencode({
    "Version": "2008-10-17",
    "Statement": [
        {
            "Sid": "",
            "Effect": "Allow",
            "Principal": {
                "Service": "elasticmapreduce.amazonaws.com"
            },
            "Action": "sts:AssumeRole"
        },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "emr-service-policy-attach" {
   role = "${aws_iam_role.spark_cluster_iam_emr_service_role.id}"
   policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonElasticMapReduceRole"
}

resource "aws_iam_role" "spark_cluster_iam_emr_profile_role" {
    name = "spark_cluster_emr_profile_role"
    assume_role_policy = jsonencode ({ 
    "Version": "2008-10-17",
    "Statement": [
        {
            "Sid": "",
            "Effect": "Allow",
            "Principal": {
                "Service": "ec2.amazonaws.com"
            },
            "Action": "sts:AssumeRole"
        }
    ]
})
}

resource "aws_iam_role_policy_attachment" "profile-policy-attach" {
   role = "${aws_iam_role.spark_cluster_iam_emr_profile_role.id}"
   policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonElasticMapReduceforEC2Role"
}

resource "aws_iam_instance_profile" "emr_profile" {
   name = "spark_cluster_emr_profile"
   role = "${aws_iam_role.spark_cluster_iam_emr_profile_role.name}"
}
