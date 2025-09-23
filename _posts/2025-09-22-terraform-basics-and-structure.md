---
layout: post
comments: true
title: Infraestrutura como Código (IaC) Seu Primeiro Deploy com Terraform
date: 2025-09-22 21:00:00
categories: dev
icon: fas fa-code
description: Descubra como transformar código em servidores!  ...
image: https://adictosaltrabajo.com/wp-content/uploads/2020/06/og-image-large-e60c82fe.png
---

# Conceitos Essenciais do Terraform

O Terraform é uma ferramenta de Infraestrutura como Código (IaC) desenvolvida pela HashiCorp, permitindo a definição, provisionamento e gerenciamento de infraestrutura de forma declarativa e automatizada.

## Providers

Os **providers** são responsáveis por interagir com APIs de serviços de infraestrutura, como AWS, Azure, Google Cloud, entre outros. Eles permitem que o Terraform crie, modifique e destrua recursos nesses serviços.

```hcl
provider "aws" {
  region = "us-west-2"
}
```

## Resources (Recursos)

Os **resources** representam os componentes da infraestrutura que você deseja criar ou gerenciar, como instâncias de máquinas virtuais, buckets de armazenamento, regras de firewall, etc.

```hcl
resource "aws_instance" "example" {
  ami           = "ami-12345678"
  instance_type = "t2.micro"
}
```

## Variables (Variáveis)

As **variáveis** permitem parametrizar os recursos, tornando o código mais reutilizável e flexível.

```hcl
variable "instance_type" {
  type    = string
  default = "t2.micro"
}
```

## Outputs

Os **outputs** são valores que o Terraform retorna após a execução, úteis para fornecer informações sobre os recursos criados, como endereços IP ou IDs de instâncias.

```hcl
output "instance_ip" {
  value = aws_instance.example.public_ip
}
```

## State (Estado)

O **state** é o arquivo que mantém o mapeamento entre os recursos definidos no código e os recursos reais na infraestrutura. Ele é essencial para o Terraform determinar o que precisa ser criado, modificado ou destruído.

## Plan / Apply / Destroy

- `terraform plan`: Gera um plano de execução, mostrando o que será alterado na infraestrutura.
- `terraform apply`: Aplica as mudanças definidas no código à infraestrutura.
- `terraform destroy`: Remove todos os recursos gerenciados pelo Terraform.

---

# Estrutura Recomendada de Arquivos

Uma boa estrutura de arquivos facilita a manutenção e escalabilidade do projeto. Abaixo está uma estrutura modularizada e organizada:

```
projeto_terraform/
│
├── modules/                # Módulos reutilizáveis
│   ├── webserver/          # Módulo para servidor web
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   └── database/           # Módulo para banco de dados
│       ├── main.tf
│       ├── variables.tf
│       └── outputs.tf
│
├── envs/                   # Ambientes
│   ├── dev/                # Ambiente de desenvolvimento
│   │   ├── main.tf
│   │   └── terraform.tfvars
│   ├── staging/            # Ambiente de staging
│   │   └── terraform.tfvars
│   └── prod/               # Ambiente de produção
│       └── terraform.tfvars
│
├── main.tf                 # Arquivo principal de configuração
├── variables.tf            # Declaração de variáveis
├── outputs.tf              # Definição de outputs
├── providers.tf            # Configuração dos providers
└── versions.tf             # Versões do Terraform e dos providers
```

## Descrição dos Arquivos

- `main.tf`: Contém a definição dos recursos principais da infraestrutura.
- `variables.tf`: Declara as variáveis utilizadas nos arquivos de configuração.
- `outputs.tf`: Define os valores que serão retornados após a execução.
- `providers.tf`: Configura os providers necessários para o projeto.
- `versions.tf`: Especifica as versões mínimas do Terraform e dos providers a serem utilizados.

## Módulos

Os módulos são unidades reutilizáveis de configuração. Eles permitem organizar o código de forma modular, facilitando a manutenção e reutilização em diferentes partes do projeto.

```hcl
module "webserver" {
  source = "./modules/webserver"
  instance_type = var.instance_type
}
```

## Ambientes

A estrutura de ambientes permite isolar configurações específicas para diferentes estágios do ciclo de vida do projeto, como desenvolvimento, staging e produção.

```hcl
module "dev" {
  source = "../modules/webserver"
  instance_type = "t2.micro"
}
```

