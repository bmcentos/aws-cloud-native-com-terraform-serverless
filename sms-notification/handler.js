'use strict';


const messagebird = require('messagebird')(proccess.env.MESSAGE_BIRDS_API_KEY);
const util = require('util')
util.promisify(messagebird.message.create)

module.exports.hello = async (event) => {
  const smsPromises = []
  for (const record of event.Records) {
    const message = JSON.parse(record.body).message
    smsPromises.push(messagebird.messages.create()({
    originator: 'proccess.env.SMS_PHONE_FROM',
    recipientis: [proccess.env.SMS_PHONE_TO],
    body:  message
  }))
  await Promise.all(smsPromises)
  console.log('SMS enviado com sucesso!!!')
  }
}