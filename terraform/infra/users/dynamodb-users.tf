#Cria a tabela no dynamoDb
resource "aws_dynamodb_table" "users" {
    name = "${var.envirmonment}-users"
    hash_key = "id"
    attribute {
      name = "id"
      type = "S"
    }

write_capacity = "${var.write_capacity}"
read_capacity = "${var.read_capacity}"

#Criando GSI (Tabela secundaria para validação de login)
attribute {
  name = "email"
  type = "S"

}

global_secondary_index {
  name = "${var.envirmonment}-email-gsi"
  projection_type = "ALL"
  hash_key = "email"
  write_capacity = "${var.write_capacity}"
  read_capacity = "${var.read_capacity}"
}
  
}

#Exporta nome da tabela dynamoDb para o SSM
resource "aws_ssm_parameter" "dynamodb_users_table" {
    name = "${var.envirmonment}-dynamodb-users-table"
    type = "String"
    value = "${aws_dynamodb_table.users.name}"
}

#Cria um recurso para que a função LAMBDA possa referenciar o indice GSI
resource "aws_ssm_parameter" "email-gsi" {
    name = "${var.envirmonment}-email-gsi"
    type = "String"
    value = "${var.envirmonment}-email-gsi"
  
}