resource "aws_iam_policy" "login_policy" {
  name = "${var.environment}-login-policy"

  #Utiliza o template definido em templates/dynamodb-policy.tpl, utilizando as variaveis definidas no arquivo
  policy = templatefile("${path.module}/templates/dynamodb-policy.tpl", {
    action = "dinamodb:Query",
    resource = "${aws_dynamodb_table.users.arn}/index/${var.environment}-email-gsi"
  })

    tags = {
    tag-key = "${var.environment}-policy-login"
  }
}
