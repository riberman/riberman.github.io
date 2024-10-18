FROM ruby:3

# Instalar Node.js e dependências necessárias
RUN apt-get update && apt-get install -y build-essential nodejs

# Definir diretório de trabalho
WORKDIR /srv/jekyll

# Copiar arquivos do projeto
COPY Gemfile* ./

# Instalar gems com Bundler
RUN bundle install

# Copiar restante do projeto
COPY . .

# Expor a porta 4000
EXPOSE 4000

# Comando para rodar o servidor Jekyll
CMD ["bundle", "exec", "jekyll", "serve", "--host", "0.0.0.0"]
