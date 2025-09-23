---
layout: post
comments: true
title: Android não Salva Dados Quando A Tela É Rotacionada Ou Teclado É Conectado
date: 2019-04-12 23:22:00
categories: dev android
icon: fab fa-android
description: Como corrigir os problemas no android com rotação de tela, ou alterações nas entradas de teclado como leitoras de códigos de barras e outros equipamentos conectados  ...
image: https://lh5.ggpht.com/0QQ-mY4qbOYhB_a8PZki3_SzbgyHoUXpY3mgzliAlC6mOt18DxFJc5J28JixSoLdpeI
---


Problemas ao **rotacionar** a tela do android ou conectar novo **dipositivo de entrada de dados**, o android automaticamente cria novamente a tela da aplicação, e assim a entrada de texto ou dados armazenados nela são perdidos, como solucionar?  

Para resolver esse problema temos uma solução muito simples, mas primeiramente vamos entender o motivo de o android perder esses dados ao efetuar essas atualizações de tela ou dispositivos de entrada.  

Ao rotacionar a tela do aparelho, ou conectando um teclado, leitora de códigos ou outro dispositivo que gere um pequeno **toast** dizendo que o dispositivo foi conectado, essa ação é invocada pelo android avisando para que sua aplicação seja atualizada, pois existem coisas novas no dispositivo que a aplicação pode ou não utilizar...

E com isso por padrão essa chamada é invocada automaticamente e os dados da aplicação são perdidos, pois o código não diz ao android como se comportar no caso especifico.  

 Vamos ao que interessa?  

 A solução mais simples encontrada para contornar essa situação é configurar seu **AndroidManifest.xml** que fica em *app/manifests/AndroidManifest.xml*  

 Então em todas as suas activitys que não podem perder dados caso ocorra essa atualização de tela, você deve adicionar a seguinte linha de código.  


    <activity android:name=".MyActivity"
        android:configChanges="parametros necessários"
        android:label="@string/app_name">




Para  correção de atualização de tela utilize  

```
android:configChanges="orientation|screenSize"
```  

Para novos dispositivos de entrada conectados utilize  

```
android:configChanges="keyboard|keyboardHidden"
```  

Um exemplo abaixo utilizando as duas opções ao mesmo tempo

```
<activity android:name=".MyActivity"
    android:configChanges="orientation|screenSize|keyboard|keyboardHidden"
    android:label="@string/app_name">
```   

*Com isso o android automaticamente entende que você quer manter as configurações dessa tela, e depois que a aplicação é atualizada os dados são recuperados, sem a menor percepção do usuário.*
