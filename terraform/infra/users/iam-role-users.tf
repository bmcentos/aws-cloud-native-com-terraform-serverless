resource "aws_iam_role" "register_iam_role" {
  name = "${var.environment}-register-iam-role"

  assume_role_policy = templatefile("${path.module}/templates/lambda-role.tpl", {})

  tags = {
    tag-key = "${var.environment}-role-users"
  }
}

resource "aws_ssm_parameter" "register_iam_role" {
    name = "${var.environment}-register-iam-policy"
    type = "String"
    value = "${aws_iam_role.register_iam_role.arn}"
  
}
