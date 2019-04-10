---
layout: post
comments: true
title: Removendo Arquivos Untracked do Git
date: 2019-04-09 23:36:00
categories: dev
icon: fab fa-github
description: Como remover arquivos ou pastas que foram criados no repositório do git, que não removidos usando checkout --  ...
image: https://img.devrant.com/devrant/rant/r_208395_eyoBm.jpg
---


É comum usando uma **IDE** ou um **Framework** a geração automática de arquivos, sejam eles de *model*, *view*, *controller*, ou qualquer mero arquivo criado.  

Se necessário desfazer essas criações automáticas precisamos deletar esses arquivos ou pastas geradas, pois desfazendo as alterações usando o comando **git checkout -- .** somente as alterações em arquivos que já existem no ultimo **commit** vão ser desfeitas, mas todas as pastas e arquivos novos ainda vão permanecer em seu **branch** atual para serem commitados.  

Para resolver isso é bem simples, basta seguir as instruções.  

Utilize o comando abaixo somente para visualizar os arquivos que estão nessa situação **antes de deletar**.


     git clean -n  

Após verificar, se for de seu interesse para deletar basta substituir o **-n** por **-f**  

    git clean -f  

Nesse caso, se existir pastas criadas elas vão permanecer, para deletar é necessário outro comando.  

    git clean -fd  
E pronto, para listar suas modificações podemos usar o comando.

    git status  
Agora todos os arquivos e pastas criadas nesse **branch** não vão estar sendo mostrados, somente os arquivos modificados já existentes no ultimo **commit** vão permanecer caso você tenha efetuado alguma alteração.
