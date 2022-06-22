resource "aws_dynamodb_table" "bookings" {
    name = "${var.environment}-bookings"
    hash_key = "id"
    attribute {
      name = "id"
      type = "S"
    }

    write_capacity = "${var.write_capacity}"
    read_capacity = "${var.read_capacity}"
    #Habilita dynamoDb Streaming (Processamento de eventos)
    stream_enabled = true
    #NEW_IMAGE, envia apenas objetos novos para o stream
    stream_view_type = "NEW_IMAGE"
  
}
resource "aws_ssm_parameter" "dynamodb_bookings_stream" {
    name = "${var.environment}-dynamodb-bookings-stream"
    type = "String"
    value = "${aws_dynamodb_table.bookings.stream_arn}"
  
}
resource "aws_ssm_parameter" "dynamodb_booking_table" {
    name = "${var.environment}-dynamodb-booking-table"
    type = "String"
    value = "${aws_dynamodb_table.bookings.name}"
  
}