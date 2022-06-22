resource "aws_iam_policy" "register_policy" {
  name = "${var.environment}-register-policy"

  policy = templatefile("${path.module}/templates/dynamodb-policy.tpl", {
    action = "dinamodb:PutItem",
    resource = "${aws_dynamodb_table.users.arn}"
  })
 
    tags = {
    tag-key = "${var.environment}-policy-users"
  }
}
