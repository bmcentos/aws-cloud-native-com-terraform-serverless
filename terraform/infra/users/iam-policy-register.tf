resource "aws_iam_policy" "register_policy" {
  name = "${var.envirmonment}-register-policy"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "dynamodb:PutItem",
        ]
        Effect   = "Allow"
        Resource = "${aws_dynamodb_table.users.arn}"
      },
      {
          "Effect": "Allow",
          "Action": [
              "logs:CreateLogGroup",
              "logs:CreateLogStream",
              "logs:PutLogEvents"
          ],
          "Resource": "*"
      }
    
    ]
  })

    tags = {
    tag-key = "${var.envirmonment}-policy-users"
  }
}
