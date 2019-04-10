---
layout: post
comments: true
title: Acessando Postgres via Terminal Ubuntu
date: 2019-04-10 01:14:00
categories: dev db
icon: fas fa-database
description: Como acessar o postgres utilizando linha de comando no Linux Ubuntu, e executando alguns comandos básicos de listagem e pesquisa  ...
image: https://sdtimes.com/wp-content/uploads/2016/05/0513.sdt-news.png
---


Está com dificuldades para utilizar a linha de comando do Postgres usando o Ubunto?  
Bom estou partindo do ponto em que seu banco de dados foi instalado, possui um usuário configurado na instalação, e o processo postgres está sendo executado em sua máquina.  

Então primeiramente para efetuar login no terminal devemos utilizar o seguinte comando.  
*substituindo postgres pelo usuário que você criou durante a configuração.*

    sudo -u postgres psql  

Primeiro vai ser necessário digitar a senha de root do linux e após isso a senha cadastrada no usuário do postgres.  

Ao efetuar isso seu terminal deve estar mostrando **postgres=#**

Nesse momento já é possível efetuar comandos, primeiramente vamos testar o comando

    \l  

Este comando vai listar todas as bases de dados do seu postgres.

Copie o name de qualquer base que deseja acessar, e para sair dessa listagem use **q**  

Então para entrar na base use

    \c mybase  

*substitua mybase pelo name da sua base.*  

Agora dentro de sua base é possivel efetuar qualquer consulta **SQL**

Antes vamos descobrir qual o nome das **tables** para efetuar as consultas.

    \d  

*esse comando lista todas as **tables** da base atual selecionada.*  

Sabendo o name da table basta usar qualquer comando.

    select * from nomedatable;  

*não esqueça do **;** ao final de qualquer comando.*    

Ao final de cada consulta para voltar ao terminal basta a tecla **q** e para sair do terminal do postgres e voltar ao linux basta usar **\q**  
