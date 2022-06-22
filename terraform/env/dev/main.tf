#Adicionado para coletar o accountId da cota AWS
data "aws_caller_identity" "current" {
  
}
module "users" {
    source = "../../infra/users"
    environment = "${var.environment}"
    write_capacity = 1
    read_capacity = 1
    jwt_secret = "${var.jwt_secret}"
    admin_id = "${var.admin_id}"
    admin_name = "${var.admin_name}"
    admin_password = "${var.admin_password}"
    admin_email = "${var.admin_email}"
}
module "booking" {
    source = "../../infra/booking"
    environment = "${var.environment}"
    write_capacity = 1
    read_capacity = 1
    #Interpola valor dooutput criado no modulo notification
    sns_notifications_arn = "${module.notification.notifications_topic_arn}"
}

module "notification" {
    source = "../../infra/notification"
    environment = "${var.environment}"
    account_id = "${data.aws_caller_identity.current.account_id}"
    region = "${var.region}"
}

module "system" {
    source = "../../infra/system"
    environment = "${var.environment}"
    email_from = "${var.email_from}"
    email_to = "${var.email_to}"
    smtp_server = "${var.smtp_server}"
    email_from_password = "${var.email_from_password}"
    sms_phone_from = "${var.sms_phone_from}"
    sms_phone_to = "${var.sms_phone_to}"
    message_bird_api_key = "${var.message_bird_api_key}"

  
}