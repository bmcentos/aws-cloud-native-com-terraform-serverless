resource "aws_sns_topic_subscription" "email_sub" {
    topic_arn = "${aws_sns_topic.notifications.arn}"
    protocol = "sqs"
    endpoint = "${aws_sqs_queue.email.arn}"
  
}

resource "aws_sns_topic_subscription" "sms_sub" {
    topic_arn = "${aws_sns_topic.notifications.arn}"
    protocol = "sqs"
    endpoint = "${aws_sqs_queue.email.arn}"
  
}