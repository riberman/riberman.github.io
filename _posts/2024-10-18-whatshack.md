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

## Extrutura básica
*Nesse passo a passo estamos ignorando a instalação do NodeJS na máquina...*
- Crie uma pasta com o nome do projeto exemplo "**whatsapp-hack**".  
- Abra o **Visual Studio Code** nessa pasta.
- Abra um **CMD/Terminal** dentro da pasta criada e execute os comando abaixo.  
<br>
    npm init -y   
    npm install venom-bot express ejs socket.io  
<br>  
- Crie um arquivo na raiz do projeto chamado de "**app.js**".
- Crie uma pasta na raiz do projeto chamada de "**views**".
- Crie dois arquivos dentro da pasta **views**, o **index.ejs** e **send.ejs**.

Após isso a sua extrutura deve estar assim:

    /whatsapp-hack
    │
    ├── /node_modules
    ├── /views                # Páginas EJS (QR Code e Envio de Mensagens)
    │   ├── index.ejs
    │   └── send.ejs
    ├── app.js                # Arquivo principal do servidor
    └── package.json  
<br>  
    
## Iniciando a codificação

No inicio do arquivo **app.js** cole o seguinte trecho, vamos conversar um pouco sobre cada linha.

    //Importando bibliotecas
    const express = require('express');
    const { create } = require('venom-bot');
    const http = require('http');
    const path = require('path');
    const socketIo = require('socket.io');
    
    //Iniciando serviços
    const app = express();
    const server = http.createServer(app);
    const io = socketIo(server);
    
    //Configurando a aplicação
    app.set('view engine', 'ejs');
    app.set('views', path.join(__dirname, 'views'));
    app.use(express.json());
    app.use(express.urlencoded({ extended:  true }));
    
    const  PORT = 3000;
    let venomClient = null;
    let venomStatus = null;
    let venomQR = null;
<br>
<br>
  Agora vamos iniciar a configuração das rotas desse servidor. Copie o trecho a seguir no mesmo arquivo **app.js** logo abaixo do código anterior.

    // URL leitura/status da conexão
    app.get('/', (req, res) => {
      res.render('index', { venomStatus, venomQR });
    });
    
    // URL envio de mensagens (Form)
    app.get('/send', (req, res) => {
        res.render('send');
    });
    
    // URL envio de mensagens (Json)
    app.post('/send-message', (req, res) => {
        const { number, message } = req.body;
    
        if (venomClient) {
            venomClient
                .sendText(`55${number}@c.us`, message)
                .then((result) => res.status(200).json({ status: 'success', result }))
                .catch((error) => res.status(500).json({ status: 'error', error }));
        } else {
            res.status(500).json({ status: 'error', message: 'WhatsApp não conectado.' });
        }
    });
    
    // Iniciar o servidor
    server.listen(PORT, () => {
        console.log(`Servidor executando na porta: ${PORT}`);
    });  

<br>
<br>
No arquivo **send.ejs** cole o seguinte trecho:

    <!DOCTYPE html>
    <html lang="pt-BR">
        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Nova Mensagem | WhatsApp Hack-Workshop</title>
        </head>
        <body>
            <h1>Envie uma Mensagem via WhatsApp</h1>
    
            <form action="/send-message" method="POST">
                <label for="number">Número:</label><br>
                <input type="text" id="number" name="number" required><br><br>
    
                <label for="message">Mensagem:</label><br>
                <textarea id="message" name="message" rows="4" required></textarea><br><br>
    
                <button type="submit">Enviar</button>
            </form>
        </body>
    </html>  

<br>
<br>
No arquivo **index.ejs** cole o seguinte trecho:  

    <!DOCTYPE html>
    <html lang="en">
        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Qr Code | WhatsApp Hack-Workshop</title>
        </head>
        <body>
            <center>  
                <h1>WhatsApp Hack-Workshop</h1>
                <p id="status"></p>
                <img id="qr"/>
            </center> 
    
            <script src="/socket.io/socket.io.js"></script>
            <script>
                const socket = io();
    
                const loading_icon_url = `https://riberman.github.io/static/img/dev/loading.gif`;
                const ok_icon_url = `https://riberman.github.io/static/img/dev/ok_icon.png`;
    
                //Recebe o status e QR do Venom (app.js)
                setQr('<%= venomQR %>');
                setStatus('<%= venomStatus %>');
    
                //Recebe o status do Venom (Socket.io)
                socket.on('status', (status) => {
                    setStatus(status);
                });
    
                //Recebe QR code (Socket.io)
                socket.on('qr', (qrCode) => {
                if (qrCode) {
                    setQr(qrCode);
                } else {
                    setQr(loading_icon_url);
                }
                });
    
                //Altera Status na tag <p id="status">
                function setStatus(status) {
                    const statusDiv = document.getElementById('status');
            
                    switch (status) {
                        case 'notLogged':
                            statusDiv.innerHTML = 'Efetue a leitura do QR Code.';
                            break;
                        case 'successChat':
                        case 'CONNECTED':
                            setQr(ok_icon_url);
                            statusDiv.innerHTML = 'Chat estabelecido com sucesso.';
                            break;
                        default:
                            setQr(loading_icon_url);
                            statusDiv.innerHTML = 'Carregando WhatsApp aguarde.';
                            break;
                    }
                }
    
                //Altera Imagem na tag <img id="qr">
                function setQr(image) {
                    const qrDiv = document.getElementById('qr');
                    qrDiv.src = image;
                }
            </script>
        </body>
    </html>  

<br>
<br>
Agora podemos testar e executar o servidor, na raiz do projeto execute:  

    node app.js  

Teste no navegador as URLs 
- [http://localhost:3000](http://localhost:3000){:target="_blank"}
- [http://localhost:3000/send](http://localhost:3000/send){:target="_blank"}

Para parar o servidor use **CTRL+C** no CMD/Terminal.
<br>
<br><br>
Até o momento já temos o básico configurado, agora precisamos integrar a nossa aplicação com o WhatsApp, e assim interagir com ele. Copie o trecho abaixo no **app.js** entre os trechos **// URL envio de mensagens (Json)** e **// Iniciar o servidor**:

    // Criando sessão Venom-bot e capturando QR/Status
    venomClient = create({
            session: 'whatsapp-bot',
            multidevice: true,
        },
        // Gerencia mudanças na variável base64Qr
        (base64Qr) => {
            venomQR = base64Qr;
            io.emit('qr', base64Qr);              
        },
        // Gerencia mudanças na variável statusFind
        (statusFind) => {
            venomStatus = statusFind;
            io.emit('status', statusFind);
    });
    
    //Configurando ações quando o cliente é inicializado.
    venomClient.then(async (client) => {
    
        // Gerencia mudanças de status
        client.onStateChange((state) => {
            venomStatus = state;
            io.emit('status', state); 
        });
    
        // Listener para mensagens recebidas
        client.onMessage(async (message) => {
            try {
                console.log('Received Message:', message);
    
                // Adicionando múltiplas condições e validações
                if (message.isGroupMsg === false) {
                    if (message.body.toLowerCase() === 'hi') {
                        await sendMessage(client, message.from, 'Bem-vindo ao Venom 🕷');
                    } else if (message.body.toLowerCase().includes('dev')) {
                        await sendMessage(client, message.from, 'Bem-vindo dev!');
                    } else if (message.from === '55NUMERO_COM_DDD@c.us') {
                        await sendMessage(client, message.from, 'Você é 55NUMERO_COM_DDD@c.us!');
                    }
                }
            } catch (error) {
                console.error('Erro onMessage:', error);
            }
        });
    }).catch((err) => {
        console.error('Erro Venom-bot:', err);
    });
    
    async function sendMessage(client, to, message) {
        try {
            const result = await client.sendText(to, message);
            console.log('Mensagem enviada:', result);
        } catch (error) {
            console.error('Erro ao enviar:', error);
        }
    }
    
    io.on('connection', (socket) => {
        console.log('Client conectado ao Socket.io');
        socket.on('disconnect', () => console.log('Client desconectado do Socket.io'));
    });  

<br>
<br>
Agora com o ambiente configurado, podemos subir o servidor novamente:

    node app.js

Com o servidor em execução abrimos o navegador e vamos para:
http://localhost:3000

- É possível visualizar a página carregando e algumas mudanças de status até que o QR Code do WhatsApp seja carregado na tela.
- Após efetuar a leitura do QR Code o nosso script é capaz de interagir com o WhatsApp, como receber mensagens, enviar mensagens, visualizar contatos e etc.  
<br>
<br>

*O projeto apresentou o básico da manipulação e integração usando o Venom Bot. Existem várias possíbilidades e aplicações dessa ferramenta, para mais informações aconselho estudar a documentação do projeto no GitHub.*  
  
## Links Úteis
- Projeto Venom Bot: [GitHub](https://github.com/orkestral/venom){:target="_blank"}
- Apresentação: [Google Slides](https://docs.google.com/presentation/d/1ujXL3OWhtRp7vYeWMHNCgQWd_bbU5nHdx0TzbB0wg5g/){:target="_blank"}
- Projeto WhatsHack: *Disponível após a apresentação.*

<br>
<br>
