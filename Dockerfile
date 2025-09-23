FROM ruby:3.4.2

# Instalar dependências do sistema (precisa para compilar gems nativas)
RUN apt-get update && apt-get install -y \
    build-essential \
    nodejs \
    libffi-dev \
    protobuf-compiler \
    && rm -rf /var/lib/apt/lists/*

# Definir diretório de trabalho
WORKDIR /srv/jekyll

# Copiar Gemfile e Gemfile.lock antes do resto (cache de build)
COPY Gemfile* ./

# Instalar gems
RUN bundle install

# Copiar o restante do projeto
COPY . .

# Expor a porta 4000
EXPOSE 4000

# Comando para rodar o servidor Jekyll
CMD ["bundle", "exec", "jekyll", "serve", "--host", "0.0.0.0"]
