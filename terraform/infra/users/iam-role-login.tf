resource "aws_iam_role" "login_iam_role" {
    name = "${var.envirmonment}-login-iam-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF

  tags = {
    tag-key = "${var.envirmonment}-role-login"
  }
}

resource "aws_ssm_parameter" "login_iam_role" {
    name = "${var.envirmonment}-login-iam-policy"
    type = "String"
    value = "${aws_iam_role.login_iam_role.arn}"
  
}
