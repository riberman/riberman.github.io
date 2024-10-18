---
layout: post
comments: true
title: WhatsApp Hack
date: 2024-10-18 13:00:00
categories: dev
icon: fas fa-code
description: Como usar uma ferramenta opensource para desenvolver integração com o WhatsApp  ...
image: https://blog.softaliza.com.br/wp-content/uploads/2023/02/WhatsApp-Image-2023-02-07-at-14.23.15.jpeg
---


Uma das atividades mais comuns utilizando o git é o comando **merge**  utilizado para mesclar **branchs,** como por exemplo quando ocorrem atualizações no branch de desenvolvimento pelos seus colegas, exatamente enquanto você trabalhava em uma funcionalidade, no momento seu branch está desatualizado, e antes de efetuar uma **pull request** para enviar suas alterações ao branch de desenvolvimento, é necessário efetuar uma junção dessas modificações.  

Primeiramente selecione o branch que foi atualizado no GitHub por seus colegas, o qual ainda não possui as alterações na sua máquina localmente.  


    git checkout branchcolegas

   Agora é necessário efetuar um **pull** para receber as atualizações no branch selecionado.  

    git pull origin branchcolegas


  Então para que não ocorra problemas efetuando uma **pull request** diretamente para o **branch** de desenvolvimento, ao fazer um **push** é recomendável criar um novo branch.  

    git checkout -b branchdetransicao  

Ou você pode utilizar o mesmo **branch** que estava trabalhando, no caso basta ir até ele.  

    git checkout meubranch


Se você escolheu a opção de criar um **branch**, é necessário efetuar o comando **merge** nele.



    git merge meubranch  

Ou se não criou um **branch** novo, você precisa trazer os arquivos do **branch** de seus colegas para o seu usando.  

    git merge branchcolegas



Em alguns casos é aberto uma tela para efetuar os comentários dessa pull request, comente ou use **ESC + : + Q**,  após isso podem ocorrer problemas na mesclagem por conta de seus colegas tiverem trabalhado nos mesmos arquivos que você, para corrigir verifique no terminal o nome dos arquivos com conflitos e abra seu editor ou IDE neles, todos os conflitos são comentados dentro do arquivo informando a sua alteração e a de seus colegas, para corrigir basta descomentar deixando somente o código correto, e após todas as correções serem efetuadas é necessário efetuar um commit.  


    git add .
    git commit -m "Exemplo efetuado merge no branch"  

Agora então é só efetuar uma **pull request** para o **branch** de desenvolvimento normalmente, efetuando um **push** ou **pull request** pelo **GitHub**.

    git push origin branchdedesenvolvimento  

*É recomendável efetuar **pull request** para branchs principais usando o **site**, onde assim que abertas repassar aos colegas com a finalidade de revisão, sendo mais seguro de não ocorrer nenhum problema nas alterações enviadas.*
