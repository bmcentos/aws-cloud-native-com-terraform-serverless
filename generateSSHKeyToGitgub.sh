#!/bin/bash
clear
if [ -z "$1" ] ; then
  echo "[-]  Necessario informar o seu e-mail do github como parametro!!!"
  echo
  echo "Uso: ./$0 email@exemplo.com"
  exit 1
fi

read -p "Voce quer criar o par de chaves para o github? [N|sim]:  " resp
resp=`echo $resp | tr [A-Z] [a-z]`

if [ "$resp" == "yes" ] || [ "$resp" == "sim" ] ; then
  echo "[+] Voce digitou $resp, Criando o par de chaves"
  #Cria o par de chaves para o seu e-mail
  ssh-keygen -t ed25519 -N '' -f ~/.ssh/id_ed25519 -C "$1" <<<y >/dev/null 2>&1
  #Inicia gerenciador de sessão SSH
  eval $(ssh-agent -s)
  #Adiciona a chave criada ao gerenciador SSH
  ssh-add ~/.ssh/id_ed25519
  #Adiciona o repositorio git
  git remote add origin ssh://git@github.com/bmcentos/aws-cloud-native-com-terraform-serverless.git
  echo "[!!] - Adicione a chave ~/.ssh/id_ed25519 em suas SSH Keys do github" 
  cat ~/.ssh/id_ed25519.pub
else
  echo "[-] Saindo..."
  exit 1
fi

  #Testa acesso ao github
  #ssh -T git@github.com
