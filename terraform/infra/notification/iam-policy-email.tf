resource "aws_iam_policy" "email_policy" {
  name = "${var.environment}-email-policy"

  #Utiliza o template definido em templates/lambda-sqs-policy.tpl, utilizando as variaveis definidas no arquivo
  policy = templatefile("${path.module}/templates/lambda-sqs-policy.tpl", {
    action = join("\",\"", [
    "sqs:ReceiveMessage",
    "sqs:DeleteMessage",
    "sqs:GetQueueAttributes"
    ]),
    resource = "${aws_sqs_queue.email.arn}"

  })

    tags = {
    tag-key = "${var.environment}-policy-email"
  }
}
