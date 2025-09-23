---
layout: post
comments: true
title: Infraestrutura como Código (IaC) Seu Primeiro Deploy com Terraform
date: 2025-09-23 17:21:00
categories: dev
icon: fas fa-code
description: Descubra como transformar código em servidores!  ...
image: https://adictosaltrabajo.com/wp-content/uploads/2020/06/og-image-large-e60c82fe.png
---

# Criando um Droplet DigitalOcean com Nginx e Hello World

---

## 1. Introdução ao Projeto

Neste workshop, vamos criar uma infraestrutura completa usando Terraform que inclui:

- Um droplet (VPS) na DigitalOcean  
- Instalação automática do Nginx  
- Uma página HTML "Hello World"  
- Configuração de acesso SSH por senha  

**Pré-requisitos:**

- Terraform instalado  
- Conta na DigitalOcean  
- Token de API da DigitalOcean  

---

## 2. Configuração Inicial do Projeto

Primeiro, vamos criar a estrutura de diretórios e arquivos do projeto:

```bash
mkdir terraform-workshop
cd terraform-workshop
```

Vamos organizar o projeto seguindo as melhores práticas do Terraform:

- `providers.tf` — Configuração do provider  
- `variables.tf` — Definição das variáveis  
- `droplet.tf` — Recurso do droplet  
- `outputs.tf` — Outputs do projeto  
- `main.tf` — Arquivo principal  
- `terraform.tfvars` — Valores das variáveis  

---

## 3. Criando o arquivo `providers.tf`

Crie o arquivo `providers.tf`:

```hcl
terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}

provider "digitalocean" {
  token = var.do_token
}
```

**Explicação:**

- `terraform` — Bloco de configuração do Terraform  
- `required_providers` — Define quais providers são necessários  
- `digitalocean` — Provider oficial da DigitalOcean  
- `version = "~> 2.0"` — Versão compatível (2.x)  
- `provider "digitalocean"` — Configuração do provider  
- `token = var.do_token` — Usa a variável para o token  

---

## 4. Criando o arquivo `variables.tf`

Crie o arquivo `variables.tf`:

```hcl
# Token da API da DigitalOcean
variable "do_token" {
  description = "Token de API da DigitalOcean"
  type = string
  sensitive = true
}

# Senha para o usuário root do droplet
variable "root_password" {
  description = "Senha para o usuário root"
  type = string
  sensitive = true
  default = "Terraform2025***"
}
```

**Explicação:**

- `variable` — Define uma variável  
- `description` — Descrição da variável  
- `type = string` — Tipo da variável  
- `sensitive = true` — Oculta o valor nos logs  
- `default` — Valor padrão (opcional)  

---

## 5. Criando o arquivo `droplet.tf`

Crie o arquivo `droplet.tf`:

```hcl
resource "digitalocean_droplet" "vps" {
  image = "ubuntu-25-04-x64"
  name = "vps-terraform"
  region = "sfo2"
  size = "s-1vcpu-512mb-10gb"
  user_data = <<-EOF
    #!/bin/bash
    # Permitir login do root por senha
    sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
    sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config
    sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config

    # Definir senha para o usuário root
    echo 'root:${var.root_password}' | chpasswd

    # Reiniciar serviço SSH
    systemctl restart sshd

    # Atualizar sistema
    apt update -y
    # Instalar nginx sem interação
    apt install -y nginx

    # Baixar página HTML hello world e fazer substituição
    curl -o /var/www/html/index.html https://softweek.nuvemapps.com.br/hello-world.html

    # Substituir texto aluno_example por teste123
    sed -i 's/aluno_example/teste123/g' /var/www/html/index.html
    # Reiniciar serviço nginx
    systemctl restart nginx
    systemctl enable nginx
  EOF

  tags = ["terraform", "vps"]
}
```

**Explicação:**

- `resource "digitalocean_droplet"` — Define um recurso droplet  
- `image = "ubuntu-25-04-x64"` — Imagem do Ubuntu  
- `region = "sfo2"` — Região São Francisco  
- `size = "s-1vcpu-512mb-10gb"` — Tamanho do droplet  
- `user_data` — Script executado na inicialização  
- `sed` — Comandos para configurar SSH  
- `chpasswd` — Define senha do root  
- `apt install -y nginx` — Instala nginx sem interação  
- etc.  

---

## 6. Criando o arquivo `outputs.tf`

Crie o arquivo `outputs.tf`:

```hcl
output "droplet_ip" {
  value = digitalocean_droplet.vps.ipv4_address
}

output "droplet_name" {
  value = digitalocean_droplet.vps.name
}

output "ssh_connection" {
  value = "ssh root@${digitalocean_droplet.vps.ipv4_address}"
}

output "website_url" {
  value = "http://${digitalocean_droplet.vps.ipv4_address}"
  description = "URL para acessar o site hello world"
}
```

---

## 7. Criando o arquivo `main.tf`

Crie o arquivo `main.tf`:

> Este arquivo principal do projeto Terraform serve como documentação e ponto de entrada. A organização modular facilita a manutenção e compreensão do código.

---

## 8. Criando o arquivo `terraform.tfvars`

Crie o arquivo `terraform.tfvars`:

```hcl
# Token da API da DigitalOcean
do_token = "seu_token_aqui"
# Senha para o usuário root (altere conforme necessário)
root_password = "Terraform2025***"
```

⚠️ **Importante:**

- Substitua `"seu_token_aqui"` pelo seu token real da DigitalOcean  
- Use uma senha forte para o root  
- Nunca commite este arquivo com tokens reais  

---

## 9. Deploy da Infraestrutura

Agora vamos fazer o deploy da infraestrutura:

```bash
terraform init
terraform plan
terraform apply
```

✅ Resultado esperado:

O Terraform criará um droplet na DigitalOcean com nginx instalado e uma página HTML hello world.

Comandos úteis:

- `terraform init` — Baixa providers e inicializa  
- `terraform plan` — Mostra o que será criado  
- `terraform apply` — Cria os recursos  
- `terraform show` — Mostra estado atual  
- `terraform output` — Mostra outputs  

---

## 10. Testando o Resultado

Após o deploy, vamos testar se tudo funcionou:

1. Ver os outputs:

   ```bash
   terraform output
   ```

2. Acessar o site:

   > Use o IP mostrado no output `website_url`  
   > Exemplo: `http://157.245.123.456`

3. Conectar via SSH:

   ```bash
   ssh root@IP_DO_DROPLET
   ```

✅ O que você deve ver:

- Uma página HTML bonita com "Hello World"  
- Nginx funcionando corretamente  
- Acesso SSH funcionando com senha  

---

## 11. Limpeza dos Recursos

Para evitar custos desnecessários, sempre destrua os recursos após os testes:

```bash
terraform destroy
```

⚠️ Atenção:

Este comando irá deletar o droplet e todos os dados nele. Certifique-se de que não há dados importantes antes de executar.

---

## 🎉 Parabéns!

Você completou o workshop de Terraform e criou sua primeira infraestrutura na nuvem!

**Próximos passos:** Explore mais recursos do Terraform, como módulos, workspaces e state remoto.
