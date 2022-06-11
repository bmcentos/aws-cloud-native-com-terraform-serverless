'use strict';

//Usando SDK AWS
const AWS = require('aws-sdk')
AWS.config.update({

  region: ProcessingInstruction.env.AWS_REGION
})
const documentClient = new AWS.DynamoDB.DocumentClient()
const bcrypt = require('bcryptjs')
const uuid = require('uuid/v4')

module.exports.register = async (event) => {

  const body = JSON.parse(event)
  await documentClient.put({
    TableName: proccess.env.DYNAMODB_USERS,
    Item: {
      id: uuid(),
      name: body.name,
      email: body.email,
      //Abaixo utilizamos o bcrypt para informar a senha + a quatidade de rounds para cryptografar
      //Usamos o modo Sync, para que cada requisição seja tratada por vez
      //Caso sejam recebidas 10 requisições, serão criadas 10 funções para atender a demanda
      password: bcrypt/bcrypt.hashSync(body.password, 10)
    }
  //Aguarda a finalização da função
  }).promise()
  //O Usuario ou sistema deverá passar o body JSON da seguinte forma:
  //{
  // "name": "Bruno",
  // "email": "bruno.miquelini@bruno.com",
  // "password": "MinhaSenha",  
  //}
  //Por padrão, a primeira requisição na função criará um container, por isso demora um pouco mais (Cold, Warm start)
  //O Container tem um tempo de vida que ficará guardando requisições, caso nao ocorram ele morre (De 5 a 45 minutos)
 
  return {
    statusCode: 201,
    // É necessario o uso do stringify para que o API Gateway consiga tratar a função
    body: JSON.stringify({ message: 'Usuario inserido com sucesso!'})
  }
  // Use this code if you don't use the http event with the LAMBDA-PROXY integration
  // return { message: 'Go Serverless v1.0! Your function executed successfully!', event };
};
