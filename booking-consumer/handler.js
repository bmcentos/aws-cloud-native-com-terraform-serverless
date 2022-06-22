'use strict';

const AWS = require('aws-sdk')
AWS.config.update({
  region: process.env.AWS_REGION
})
const SNS = new AWS.SNS()
//Utiliza a função para parser do JSON
const converter = AWS.DynamoDB.Converter
const moment = require('moment')
moment.locale('pt-br')

module.exports.listen = async (event) => {
  const snsPromises = []
  //Faz o parse do evento com a função unmarshal, para tem uma saida de log mais limpa
  for (const record of event.Records) {
    if (record.eventname === 'INSERT') {
      //A estrutura criada no evento de stream é record.dynamodb.NewImage
      const reserva = converter.unmarshall(record.dynamodb.NewImage)
      //Cria uma promise de todas as requisições, para fazer com que as requisições sejam sincronas
      //Nesse caso s requisições são assincronas
      snsPromises.push(SNS.publish({
        TopicArn: process.env.SNS_NOTIFICATIONS_TOPIC,
        Message: `Reserva efetuada: o usuario ${reserva.user.name} (${reserva.user.email}) agendou um horario em: ${moment(reserva.data).format('LLLL')}` 
      }).promise())
    }
    //Envia todas as promises de uma vez para o topico
    await Promise.all(snsPromises)
    console.log('Mensagens enviadas com sucesso!')
  }
    console.log(JSON.stringify(event))
     return { message: 'Go Serverless v1.0! Your function executed successfully!', event };
};
