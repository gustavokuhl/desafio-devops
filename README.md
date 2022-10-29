# desafio-devops

## Pré-requisitos

Para executar o projeto é neccessário:

- Conta na AWS
- Conta no Terraform Cloud

## Configuração

### AWS

Crie um usuário na AWS com as seguintes permissões:
- AmazonEC2FullAccess
- AmazonVPCFullAccess

Sete ele como acesso programático e salve as credenciais.

### Terraform Cloud

Crie uma conta no Terraform Cloud e crie um workspace.

Configure o workspace com as seguintes variáveis com o valor das credenciais da AWS:
- AWS_ACCESS_KEY_ID
- AWS_SECRET_ACCESS_KEY

Criei uma API key e salve-a.

### Github

Clone o repositório e adicione como secret as seguintes variáveis com o valor da credencial do Terraform Cloud:
- TF_API_TOKEN

## Workflow

Esse é o funcionamento do workflow `terraform.yml`:

![workflow](https://content.hashicorp.com/api/assets?product=tutorials&version=main&asset=public%2Fimg%2Fterraform%2Fautomation%2Fpr-master-gh-actions-workflow.png)