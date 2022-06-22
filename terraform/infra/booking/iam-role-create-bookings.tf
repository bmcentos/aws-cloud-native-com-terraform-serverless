resource "aws_iam_role" "create_booking_iam_role" {
  name = "${var.environment}-create-booking-iam-role"

  assume_role_policy = templatefile("${path.module}/templates/lambda-role.tpl", {})

  tags = {
    tag-key = "${var.environment}-role-bookings"
  }
}

resource "aws_ssm_parameter" "create-booking_iam_role" {
    name = "${var.environment}-create-booking-iam-policy"
    type = "String"
    value = "${aws_iam_role.create_booking_iam_role.arn}"
  
}
