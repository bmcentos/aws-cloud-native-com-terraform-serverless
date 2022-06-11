resource "aws_iam_policy_attachment" "register_policy_attachment" {
    name = "${var.envirmonment}-register_attachment"
    roles = ["${aws_iam_role.register_iam_role.name}"]
    policy_arn = "${aws_iam_policy.register_policy.arn}"
    

}