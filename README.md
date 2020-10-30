# Modelo docker PHP com Xdebug, nginx e mysql
Modelo docker compose contendo PHP com Xdebug, nginx e mysql funcionando integrados

## Detalhes dos containers a serem montados

### Mysql:
- Para alterar a senha do usuario root, alterar valor de service mysql
```bash
    environment:
      MYSQL_ROOT_PASSWORD: 1234
```

- Foi redirecionado a porta 3306 do container mysql para 3307 do host, sendo assim para fazer conexão por exemplo no MySQL Workbench no host utilizar IP localhost Port 3307
```bash
    ports: 
        - "3307:3306"
```

- Para que não perca as informações inseridas na base toda vez que o container for destruido, as informações serão salvas na pasta /mysql/data, pode ser alterado na seção
```bash
    volumes: 
    - ./mysql/data:/var/lib/mysql
```

### Php:
- Pasta /html será a onde ficará os projetos a serem executados
```bash
    volumes: (nginx e php)
        - ./html:/html
```

### Nginx:
- Porta para rodar nginx esta como 8080 pra evitar conflito caso tenha rodando algo na 80, mas pode ser alterado caso deseje
```bash
    ports:
        - "8080:80"
```

- Alterações de configuração do nginx pode ser acessado em /config/hosts/default.conf

## DOCKER

Para rodar o docker-compose, primeiro faça a [instalação do docker](www.docker.com/products/docker-desktop)
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

## WEB

No host para testar acessar:
[locahost:8080](locahost:8080)

## XDEBUG

Para utilização do Xdebug no VSCode utilizar os modelos launch.json

Para verificar se tem algo rodando na porta 9000
```bash
sudo lsof -i:9000
```

## OUTROS

Outros exemplos de comandos para acesso e controle de containers:

- Para acessar um container no terminal:
```bash
docker exec -it nomedocontainer /bin/bash
```

- Reiniciar o nginx apos alteração de configuração:
```bash
docker exec -it nginx-container /bin/bash
service nginx restart
```
ou
```bash
docker exec -it nginx-container service nginx restart
```

- Rodar um script sql no banco (usando script exemplo da pasta)
```bash
docker exec -i mysql-container mysql -uroot -p1234 < script.sql
```

- Verificar dados inseridos
```bash
docker exec -it mysql-container mysql -uroot -p1234
SELECT * FROM test.tab;
```