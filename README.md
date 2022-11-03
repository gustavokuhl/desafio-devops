# desafio-devops

## Demo

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

Faça um fork do repositório e adicione como secret as seguintes variáveis com o valor da credencial do Terraform Cloud:
- TF_API_TOKEN

## Como rodar

Com o Fork do repositório, clone o Fork (esse repositório dentro do SEU Github).

Crie uma branch do projeto.

```bash
git checkout -b workspace-name
```

Altere o arquivo [provider.tf](https://github.com/gustavokuhl/desafio-devops/blob/main/provider.tf), alterando os valores de organization e workspace.name.

Commite o arquivo e envie ele para o repositório

```bash
git add .
git commit -m "refactor(provider.tf): change the terraform cloud data"
git push -u origin workspace-name
```

Abra o seu repositório no Github e crie uma PR com a sua alteração, trazendo da branch `workspace-name` para a `main`.

Verifique o resultado da action de Terraform plan.

Realize o merge das alterações.

Verique a nova action de Terraform apply que será executada.

## Workflow

Esse é o funcionamento do workflow `terraform.yml`:

![workflow](https://content.hashicorp.com/api/assets?product=tutorials&version=main&asset=public%2Fimg%2Fterraform%2Fautomation%2Fpr-master-gh-actions-workflow.png)
