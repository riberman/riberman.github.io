---
layout: post
title: Como Clonar Branch do Upstream  
date:   2019-04-03 23:42:00
categories: dev
---

## Como Clonar Branch do Upstream  

Já lhe deve ter ocorrido o caso de que seu **Fork** precisa de um **Branch** que foi criado somente no repositório principal, mas no seu não é possivel encontralo.  

A solução para os seus problemas é a configuração correta de seu **Upstream**.  

Vamos lá?  

### Abra seu terminal  

Qual o motivo de configurar um **Upstream**?  
Ao efetuar um **Fork** seu novo repositório vai ter um endereço de **origin** que é o seu próprio link do novo   repositório, como exemplo **myname/myfork**, com isso ao efetuar os comandos básicos **push** e **pull**, eles serão efetuados nessa origem. Mas trabalhando em equipes é necessário além de ter meu repositório local, ter o repositório remoto para conseguir copiar possíveis implementações dos meus colegas. E assim então é necessário a configuração do Upstream para linkar o meu fork local com o Remoto.

Vá até seu **branch** master.  
```markdown
$ git checkout master
```  

Verifique se seu repositório possui um **Upstream** executando esse comando.  
```markdown
$ git fetch upstream
```  
Se retornar *fatal: 'upstream' does not appear to be a git repository* é necessário efetuar os seguintes passos.  

Vá até o repositório que você efetuou o **Fork** e copie o link **SSH** ou **HTTPS** para colar no comando.
```markdown
$ git remote add upstream https://github.com/user/repo.git
```

Para confirmar use o comando  
```markdown
$ git remote -v
```  
Esse comando deve retornar algo como isso  
*origin      https://github.com/myuser/repo.git (fetch)  
origin      https://github.com/myuser/repo.git (push)  
upstream    https://github.com/user/repo.git (fetch)  
upstream    https://github.com/user/repo.git (push)*  

Agora o comando abaixo deve ser executado sem erros  
```markdown
$ git fetch upstream
```  
E finalmente para copiar um **Branch remoto** para um novo **Branch local**  
```markdown
$ git checkout -b newbranchlocal upstream/branchremoto
```  

Para efetuar merge de um **Branch** remoto com seu local já existente basta usar a referência **upstream/branchremoto**  
```markdown
$ git merge hotfix upstream/branchremoto
```  
*Nesse caso não esqueça de estar no branch correto antes do merge.*
