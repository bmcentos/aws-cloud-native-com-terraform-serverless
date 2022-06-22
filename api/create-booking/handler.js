const AWS = require('aws-sdk')
const { randomUUID } = require('crypto')
AWS.config.update({
    region: proccess.env.AWS_REGION
})
const documentClient = new AWS.DynamoDB.DocumentClient()
const uuid = require('uudi/v4')

module.exports.create = async event => {
    const body = JSON.parse(event.body)
    await documentClient.put({
        TableName: proccess.env.DYNAMODB_BOOKINGS,
        Item: {
            id: uuid(),
            date: body.date,
            user: event.requestContext.authorizer
        }
    }).promise()
    event.req
    uestContext.authorizer
   return {
       statusCode: 200,
       body: JSON.stringify({message: 'Agendamento efetuado com sucesso!'})
   } 
}