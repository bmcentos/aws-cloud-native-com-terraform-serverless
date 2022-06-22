resource "aws_iam_policy" "sms_policy" {
  name = "${var.environment}-sms-policy"

  #Utiliza o template definido em templates/lambda-sqs-policy.tpl, utilizando as variaveis definidas no arquivo
  policy = templatefile("${path.module}/templates/lambda-sqs-policy.tpl", {
    action = join("\",\"", [
    "sqs:ReceiveMessage",
    "sqs:DeleteMessage",
    "sqs:GetQueueAttributes"
    ]),
    resource = "${aws_sqs_queue.sms.arn}"

  })

    tags = {
    tag-key = "${var.environment}-policy-sms"
  }
}
