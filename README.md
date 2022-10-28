# desafio-devops

## Requerimentos

1 - Você deve adicionar um usuário IAM de acesso programático com permissões de administrador para os módulos EC2 e VPC.
2 - Você deve adicionar uma Key Pair para acesso SSH aos servidores EC2.

Ambas as informações devem ser preenchidas no arquivo `variables.tf`.

## Execução

Iniciar o projeto Terraform:

```bash
terraform init
```

Validar o projeto:

```bash
terraform validate
```

Aplicar o projeto:

```bash
terraform apply
```

Destruir o projeto (a infraestrutura será destruída dentro da AWS):

```bash
terraform destroy
```