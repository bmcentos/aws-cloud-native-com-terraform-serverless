resource "aws_iam_policy" "login_policy" {
  name = "${var.envirmonment}-login-policy"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "dynamodb:Query",
        ]
        Effect   = "Allow"
        Resource = "${aws_dynamodb_table.users.arn}/index/${var.envirmonment}-email-gsi}"
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
    tag-key = "${var.envirmonment}-policy-login"
  }
}
