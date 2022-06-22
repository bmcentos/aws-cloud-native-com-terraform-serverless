resource "aws_iam_role" "email_iam_role" {
    name = "${var.environment}-email-iam-role"

  assume_role_policy = templatefile("${path.module}/templates/lambda-role.tpl", {})

  tags = {
    tag-key = "${var.environment}-role-email"
  }
}

resource "aws_ssm_parameter" "email_iam_role" {
    name = "${var.environment}-email-iam-policy"
    type = "String"
    value = "${aws_iam_role.email_iam_role.arn}"
  
}
