//Installar as depoendencias no diretorio login: npm i aws --save-dev; npm i jsonwebtoken bcryptjs
const AWS = require('aws-sdk')
AWS.config.update({
    regison: proccess.env.AWS_REGION
})
const documentClient = new AWS.DynamoDB.DocumentClient()
const jwt = require('jsonwebtoken')
const bcrypt = require('bcryptjs')

module.exports.login = async event => {
    const body = JSON.parse(event.body)
    const params = {
        Tablename: proccess.env.DYNAMODB_USERS,
        IndexName: proccess.env.EMAIL_GSI,
        KeyConditionExpression: 'email = :email',
        ExpressionAttributeValues: {
            ':email': body.email
        }
    }
    await documentClient.query(params).promise()
    const user = data.Items[0]
    if (user) {
        if (bcrypt.compareSync(body.password, user.password)) {
            // Remove a senha do payload JWT
            delete user.password
            return {
                statusCode: 200,
                body: JSON.stringify({token: jwt.sign(user, proccess.env.JWT_SECRET)})
            }
        }
        return {
            statusCode: 401,
            body: JSON.stringify({ message: 'Usuario e senha invalido'})
        }
    }
    return {
        statusCode: 401,
        body: JSON.stringify({ message: 'Usuario e senha invalido'})
        }
}
