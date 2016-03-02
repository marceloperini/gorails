# GORAILS

Esse é o código fonte do site [GORAILS](http://www.gorails.com.br/).
GORAILS tem como objetivo desenvolver um portal aonde todos os desenvolvedores de goiás e do brasil também possam se unir para beneficar a comunidade rails.


## Configuração Inicial

Esse projeto está sendo desenvolvido usando Ruby 2.0.0. Se você estiver utilizando [rvm](http://rvm.beginrescueend.com/)
ou [rbenv](https://github.com/sstephenson/rbenv) ele vai selecionar a versão exata em desenvolvimento
especificada no arquivo [.ruby-version](https://github.com/RubyCastsBrasil/RubyCastsBrasil/blob/master/.ruby-version).

- Crie um arquivo de configuração do banco de dados:
```shell
cp config/database.example.yml config/database.yml
```
- Execute o comando `rake db:create` para cria seu banco de dados.
- Execute o comando `rake db:migrate` para criar todas as tabelas no seu banco de dados.
- Execute o comando `rails s` para subir o servidor [rails](https://github.com/rails/rails)

## Testes [![Build Status](https://travis-ci.org/gorails/gorails.svg?branch=master)](https://travis-ci.org/gorails/gorails)
 
## Dependências 

Esse projeto utiliza o [bundler](http://bundler.io) para controle de dependências `ruby`.
Projeto também monitorado pelo [gemnasium](https://gemnasium.com).

## Controle da Qualidade [![Coverage Status](https://coveralls.io/repos/github/gorails/gorails/badge.svg?branch=master)](https://coveralls.io/github/gorails/gorails?branch=master)


## Garantia da Qualidade 

Para garantir a qualidade, é utilizado um guia de estilos, boas práticas e má praticas.
Essa garantia é monitorada pelo [Code Climate](https://codeclimate.com) e pelo [houndci](http://houndci.com).
O Code Climate checa por má práticas de programação em relação a estrutura do código enquanto 
que o Houndci checa má práticas na sintaxe do código, isto é, se a leitura do mesmo não é 
demasiada complicada.

## Documentação



## Gerenciamento de Projeto

[![Throughput Graph](https://graphs.waffle.io/gorails/gorails/throughput.svg)](https://waffle.io/gorails/gorails/metrics)


## Discussões 

Para discussões relacionadas ao projeto, é utilizado o [slack](https://go-railsslack.com) que disponibiliza
um chat em tempo real.

## Triagem de tarefas

Trello(https://trello.com)
