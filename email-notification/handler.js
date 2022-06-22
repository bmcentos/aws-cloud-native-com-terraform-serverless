'use strict';
//Uso de lib nodemailer para envio de emails "npm i nodemailer"
  const nodemailer = require('nodemailer')
  const transporter = nodemailer.createTransport({
    host: process.env.SMTP_SERVER,
    port: 465,
    secure: true, // true for 465, false for other ports
    auth: {
      user: process.env.EMAIL_FROM, // generated ethereal user
      pass: process.env.EMAIL_FROM_PASSWORD, // generated ethereal password
    },
  });

  // send mail with defined transport object
  module.exports.send = async (event) => {

    for (const record of event.Records) {
      //Faz o parser do JSON que é recebido na função, para pegar apenas o conteudo do campo message
      const message = JSON.parse(record.body).Message
      //Cria promisse para envio assincrono
      emailPromises.push(transporter.sendEmail({
        from: `"Admin 👻" <${proccess.env.EMAIL_FROM}>`, // sender address
        to: proccess.env.EMAIL_TO,
        subject: "Reserva efetuada!  ✔", // Subject line
        text: message, // plain text body
        html: message, // html body
  }));
  await Promise.all(emailPromises)
  console.log("Emails enviados: %s");
  return { message: 'Go Serverless v1.0! Your function executed successfully!', event };
}
};
