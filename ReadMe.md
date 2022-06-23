### Projeto baseado no curso aws-cloud-native-com-terraform-serverless-framework (Udemy)
```
https://www.udemy.com/course/aws-cloud-native-com-terraform-serverless-framework/ (Thales Minussi)
```

### Instalando componentes e dependencias
	-Install Terraform
	-Install awscli
	apt install awscli
	-Configure aws credencials
	aws configure (Access/Secret key)
	-Gitignore
	echo -e ".*\nnode_modules" > .gitignore
	-Install npm
	apt install npm
	-Install npm serverless module
	npm install -g serverless
	-Create app template
	sls create --template aws-nodejs --path api
	cd api
	vi serverless.yml
		Uncomment: #events #Criando endpoint API

				- http:
				    path: dev/hello (dev/prod)
				    method: get
  	-Deploy in AWS
	sls deploy --stage dev  
	sls deploy --stage prod
		- O deploy gera o s3, cloudformation, api gateway e lambda function
	-Remove Deploy
	sls remove


	-Terraform + Serverless
		- AWS System Manager (Input de valores ensiveis)
			Valores inputados no DinamoDB


	-Apos os testes
	cd terraform/env/dev
	terraform destroy
        cd api/
	sls remove


#### 
#O Dynaomdb não tem recurso de gerar hashes para senhas, por isso é necessario utilizar os recursos
	- bcrypt.js (Alternativa (30% mais lenta)  ao bcrypt, que não roda no Lambda) 
	- uuid
	
	-Intalando as libs:
	npm i uuid
	npm i bcryptjs
	npm aws-sdk --save-dev

#No DynamoDB por padão só é possivel fazer query pelo ID, por isso é necessario criar um GSI (Global Secondary Index) para o campo que queremos fazer a validação de login



#Trabalhando com template file do terraform
	- path	
	- args
#Dentro do modulo, criar o diretorio templates e o arquivo .tpl
	- mkdir template && touch policy.tpl
		- A variavel dentro do arquivo tpl é chamda com "${var}"

		Para passar o arquivo de templates, usar por exemplo:
		  assume_role_policy = templatefile("${path.module}/templates/lambda-role.tpl", {
    		service = "lambda.amazonaws.com",
    		effect = "Allow"
  		})

#Criando possibilidade de udo de JWT Token
	- É criado uma string baseb6 de 32c para assinatura dos tokens ao se fazer o login.
		- Essa string será armazenada no SSM
	- o login será realizado da seguinte forma	
		- Usuario será buscado por e-mail na tabela GSI
		- Será comparada a senha do email com a passada no login
		- Se for validada o servidore irá gerar um token com a asinatura baseada na SECRET
		#cd api/login
		#npm init; npm i aws --save-dev; npm i jsonwebtoken bcryptjs


#lib momentjs, faz a manipulação de timestamp
	-npm i moment
#função unmarshal do DynamoDB.converter, faz parser de JSON
	#Função booking-consumer


#Para exportar valores de variaveis ou recurso para outros modulos no terraform, usar o output


#SNS
	-Caso o SNS não tenha subscribers para fazer o fanout, a mensagem é perdida

#Provedor de amemail utilizado
	- zoho mail (https://www.zoho.com/pt-br/mail/)
	- Para configurar o terraform com as credenciais, caso necessario autere o secret.auto.variables.tfvars, o smtp server, e ajuste no sistema as credenciais em:
		export TF_VAR_email_from_password=
		export TF_VAR_email_from=
		export TF_VAR_email_to = ""


SMS: messagebird
EMAIL: zoho

sls create --template aws-nodejs --path sms-notification
npm i messagebird
sls deploy --force


Tunning de memoria ram de função LAMBDA
	- minimo 128MB
	- O Ideal é realizar testes adicionando memoria, até chegar em um valor de desempenho aceitavel



	Criando usuarios:
	curl -XPOST URL/dev/users -d "
	{
		"name": "User",
		"email": user@user.com",
		"password": "UserPass"
	}

	Login (Coletando o Token):
	curl -XPOST URL/dev/login -d "
	{
		"email": user@user.com",
		"password": "UserPass"
	} | cut -d ":" -f2

	Agendamento:

	curl -H 'Authorization: TOKEN' -XPOST URL/dev/login -d "
	{
		"date": 100000000000
	} 


#Encriptando arquivos sensiveis antes de enviar para o github

	- git-crypt
		 sudo apt install git-crypt
		 git-crypt init
		 vi .gitattributes
		 	secretfile filter=git-crypt diff=git-crypt
			#Ira encriptar os arquivos que contem a palavra secrets.*, que possuem valores sensiveis
			secrets.* filter=git-crypt diff=git-crypt

		Gerar chave simetrica para descriptação do arquivo
		mkdir ~/.keys && git-crypt export-key ~/.keys/proj.key

	
