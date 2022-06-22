resource "aws_iam_policy" "create_booking_policy" {
  name = "${var.environment}-create-booking-policy"

  policy = templatefile("${path.module}/templates/dynamodb-policy.tpl", {
    action = "dinamodb:PutItem",
    resource = "${aws_dynamodb_table.bookings.arn}",
    sns_topic = ""

  })
 
    tags = {
    tag-key = "${var.environment}-policy-booking"
  }
}
