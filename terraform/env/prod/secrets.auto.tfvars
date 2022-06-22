#Gerando secret base64 de 32 bits
#openssl rand -base64 32 = iNF2nzPaaAf73RngAYcwaL7VXOikas6py5UHwfibiio=
jwt_secret = "M1ktEAEQMr9zwC/9xiR9SgnEJ93Dq6wmq5XAlW1UVFU="
#Gerando UUID randomicamente: curl -s https://www.uuidgenerator.net/version4| grep "generated-uuid"| cut -d ">" -f2| cut -d "<" -f1
admin_id = "843b6fd2-24fe-48a8-9e9e-52bbef8e7900"
admin_email = "admin@company.com"
admin_name = "Admin"
#Encryptada no site: https://bcrypt-generator.com/ (admin, 10 rounds)
admin_password = "$2a$10$zs6vDuWxkJ61u8NvT7NBreW.0ic2wMv3wTJQI5XhmJXeASKVzyxJq"
#email_from = ""
#email_from_password = ""
#Site Temp email
#email_to = ""
smtp_server = "smtp.zoho.com"
message_bird_api_key = ""
sms_phone_from = ""
sms_phone_to = ""

