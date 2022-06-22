resource "aws_sqs_queue" "sms" {
    name = "${var.environment}-queue-sms"
    policy = templatefile("${path.module}/templates/sqs-sns-policy.tpl",
      {
        resource = "arn:aws:sqs:${var.region}:${var.account_id}:${var.environment}-queue-sms",
        source_arn = "${aws_sns_topic.notifications.arn}" 
      }
    )
    redrive_policy = jsonencode({
      deadLetterTargetArn = aws_sqs_queue.sms_dlq.arn
      maxReceiveCount     = 3
    })
  
}

resource "aws_ssm_parameter" "sms-sqs" {
    name = "${var.environment}-email-sms"
    type = "String"
    value = "${aws_sqs_queue.sms.arn}"  
}

resource "aws_sqs_queue" "sms_dlq" {
    name = "${var.environment}-queue-sms-dlq"
  
}