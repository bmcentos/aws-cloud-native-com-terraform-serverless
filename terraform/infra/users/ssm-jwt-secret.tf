resource "aws_ssm_parameter" "jwt_secret" {
    name = "${var.environment}-jwr-secret"
    type = "String"
    value = "${var.jwt_secret}"
  
}