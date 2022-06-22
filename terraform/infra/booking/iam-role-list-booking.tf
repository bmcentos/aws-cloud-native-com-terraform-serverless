resource "aws_iam_role" "list_booking_iam_role" {
    name = "${var.environment}-listbooking-iam-role"

  assume_role_policy = templatefile("${path.module}/templates/lambda-role.tpl", {})

  tags = {
    tag-key = "${var.environment}-role-list-booking"
  }
}

resource "aws_ssm_parameter" "list-booking_iam_role" {
    name = "${var.environment}-list-booking-iam-policy"
    type = "String"
    value = "${aws_iam_role.list_booking_iam_role.arn}"
  
}
