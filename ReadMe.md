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
