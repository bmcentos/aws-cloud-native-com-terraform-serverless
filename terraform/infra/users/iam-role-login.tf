resource "aws_iam_role" "login_iam_role" {
    name = "${var.environment}-login-iam-role"

  assume_role_policy = templatefile("${path.module}/templates/lambda-role.tpl", {})

  tags = {
    tag-key = "${var.environment}-role-login"
  }
}

resource "aws_ssm_parameter" "login_iam_role" {
    name = "${var.environment}-login-iam-policy"
    type = "String"
    value = "${aws_iam_role.login_iam_role.arn}"
  
}
