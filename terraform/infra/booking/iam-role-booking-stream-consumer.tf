resource "aws_iam_role" "booking_stream_consumer_iam_role" {
    name = "${var.environment}-booking-stream-consumer-iam-role"

  assume_role_policy = templatefile("${path.module}/templates/lambda-role.tpl", {})

  tags = {
    tag-key = "${var.environment}-booking-stream-consumer-iam-role"
  }
}

resource "aws_ssm_parameter" "booking_stream_consumer" {
    name = "${var.environment}-booking-stream-consumer-iam-role"
    type = "String"
    value = "${aws_iam_role.list_booking_iam_role.arn}"
  
}
