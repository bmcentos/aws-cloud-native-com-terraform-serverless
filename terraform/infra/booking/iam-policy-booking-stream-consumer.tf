resource "aws_iam_policy" "booking_stream_consumer_iam_policy" {
  name = "${var.environment}-booking-stream-consumer"

  #Utiliza o template definido em templates/dynamodb-policy.tpl, utilizando as variaveis definidas no arquivo
  policy = templatefile("${path.module}/templates/dynamodb-policy.tpl", {
    #Adiciona lista de valores na action 
    #sintaxe join("<delimitador>","<novo_delimitador>", [LISTA])
    action = join("\",\"", [
      "dynamodb:DescribeStream",
      "dynamodb:GetRecords",
      "dynamodb:GetShardsIterator",
      "dynamodb:ListStreams"]),
    resource = "${aws_dynamodb_table.bookings.stream_arn}"
    #Variavel interpolada do template notifications
    sns_topic = "${var.sns_notifications_arn}"
  })

    tags = {
    tag-key = "${var.environment}-booking-stream-consumer-policy"
  }
}
