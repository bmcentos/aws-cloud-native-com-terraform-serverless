resource "aws_iam_role" "sms_iam_role" {
    name = "${var.environment}-sms-iam-role"

  assume_role_policy = templatefile("${path.module}/templates/lambda-role.tpl", {})

  tags = {
    tag-key = "${var.environment}-role-sms"
  }
}

resource "aws_ssm_parameter" "sms_iam_role" {
    name = "${var.environment}-sms-iam-policy"
    type = "String"
    value = "${aws_iam_role.sms_iam_role.arn}"
  
}
