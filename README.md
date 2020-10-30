# Modelo docker PHP com Xdebug, nginx e mysql
Modelo docker compose contendo PHP com Xdebug, nginx e mysql funcionando integrados

## Mysql:
- Para alterar a senha do usuario root, alterar valor de service mysql, na seção
    environment:
      MYSQL_ROOT_PASSWORD: 1234

- Foi redirecionado a porta 3306 do container mysql para 3307 do host, sendo assim para fazer conexão por exemplo no MySQL Workbench no host utilizar IP localhost Port 3307
    ports: 
        - "3307:3306"

- Para que não perca as informações inseridas na base toda vez que o container for destruido, as informações serão salvas na pasta /mysql/data, pode ser alterado na seção
    volumes: 
    - ./mysql/data:/var/lib/mysql

## Php:
- Pasta /www será a mesma de /var/html/www do container de php
    volumes: (nginx e php)
        - ./www:/var/html/www

## Nginx:
- Porta para rodar nginx esta como 8080 pra evitar conflito caso tenha rodando algo na 80, mas pode ser alterado caso deseje
    ports:
        - "8080:80"

- Alterações de configuração do nginx pode ser acessado em /config/hosts/default.conf

# DOCKER

Para rodar o docker-compose, primeiro faça a instalação do mesmo na máquina www.docker.com/products/docker-desktop
Pelo terminal acesse a pasta onde contem o arquivo docker-compose.yml, alguns comandos:

- docker-compose up
será construida as imagens se necessário e será levantados os containers, o terminal ficará rodando os logs dos containers

- docker-compose up -d
igual ao comando anterior, não vai ter acompanhamento dos logs dos containers e não prende o terminal

- docker-compose down
Destroi a execução dos containers

- docker-compose up --build
Executar caso seja feita alterações no arquivo .dockerfile

- docker-compose build
somente constroi as imagens .dockerfile

# WEB

No host para testar acessar:
locahost:8080

# XDEBUG

Para utilização do Xdebug no VSCode utilizar os modelos launch.json

Para verificar se tem algo rodando na porta 9000
sudo lsof -i:9000

# OUTROS

Outros exemplos de comandos para acesso e controle de containers:

- Para acessar um container no terminal:
docker exec -it nomedocontainer /bin/bash

- Reiniciar o nginx apos alteração de configuração:
docker exec -it nginx-container /bin/bash
service nginx restart
ou
docker exec -it nginx-container service nginx restart

- Rodar um script sql no banco (usando script exemplo da pasta)
docker exec -i mysql-container mysql -uroot -p1234 < script.sql

- Verificar dados inseridos
docker exec -it mysql-container mysql -uroot -p1234
SELECT * FROM test.tab;