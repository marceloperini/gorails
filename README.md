# GORAILS

Esse é o código fonte do site [GORAILS](http://www.gorails.com.br/).
GORAILS tem como objetivo desenvolver um portal aonde todos os desenvolvedores de goiás e do brasil também possam se unir para beneficar a comunidade rails.


## Configuração Inicial

Esse projeto está sendo desenvolvido usando Ruby 2.4.2. Se você estiver utilizando [rvm](http://rvm.beginrescueend.com/)
ou [rbenv](https://github.com/sstephenson/rbenv) ele vai selecionar a versão exata em desenvolvimento
especificada no arquivo [.ruby-version](https://github.com/RubyCastsBrasil/RubyCastsBrasil/blob/master/.ruby-version).

- Crie um arquivo de configuração do banco de dados:
```shell
cp config/database.example.yml config/database.yml
```
- Execute o comando `rake db:create` para cria seu banco de dados.
- Execute o comando `rake db:migrate` para criar todas as tabelas no seu banco de dados.
- Execute o comando `rails s` para subir o servidor [rails](https://github.com/rails/rails)

## Testes [![Build Status](https://travis-ci.org/gorails/gorails.svg?branch=master)](https://travis-ci.org/gorails/gorails)  [![Coverage Status](https://coveralls.io/repos/github/gorails/gorails/badge.svg?branch=master)](https://coveralls.io/github/gorails/gorails?branch=master)
 
## Dependências [![Dependency Status](https://gemnasium.com/gorails/gorails.svg)](https://gemnasium.com/gorails/gorails)

Esse projeto utiliza o [bundler](http://bundler.io) para controle de dependências `ruby`.
Projeto também monitorado pelo [gemnasium](https://gemnasium.com).

## Controle da Qualidade 

## Garantia da Qualidade [![Code Climate](https://codeclimate.com/github/gorails/gorails/badges/gpa.svg)](https://codeclimate.com/github/gorails/gorails)

Para garantir a qualidade, é utilizado um guia de estilos, boas práticas e má praticas.
Essa garantia é monitorada pelo [Code Climate](https://codeclimate.com) e pelo [houndci](http://houndci.com).
O Code Climate checa por má práticas de programação em relação a estrutura do código enquanto 
que o Houndci checa má práticas na sintaxe do código, isto é, se a leitura do mesmo não é 
demasiada complicada.

## Documentação [![Inline docs](http://inch-ci.org/github/gorails/gorails.svg?branch=master)](http://inch-ci.org/github/gorails/gorails)
####Diagrama UML [PDF](https://github.com/gorails/gorails/blob/master/doc/uml_gorails.pdf) - Gerado em 11/05/2016 - 18:50
Para gerar um novo diagrama atualizado em sua maquina basta rodar o comando rake

```ruby
rake uml:generate
```

## Gerenciamento de Projeto [![Stories in Ready](https://badge.waffle.io/gorails/gorails.svg?label=ready&title=Ready)](http://waffle.io/gorails/gorails)

[![Throughput Graph](https://graphs.waffle.io/gorails/gorails/throughput.svg)](https://waffle.io/gorails/gorails/metrics)


## Discussões  

Para discussões relacionadas ao projeto, é utilizado o [Discord](https://discord.gg/7tz73A) que disponibiliza
um chat em tempo real.Instale o programa e clique no link para entrar no chat.

## Doações :moneybag:

Neste momento os responsáveis, por receber e prestar contas sobre as doações são @jcottobboni e @helioborges

#### Doações pelo PicPay

Procurar o usuário @helioborges, e efetue a Doação.



#### Doações pelo Mercado Pago 

[Doar  R$ 200,00](https://www.mercadopago.com/mlb/checkout/start?pref_id=192719033-cb23d353-2429-419f-8ca8-d0bae86ab334) /
[Doar  R$ 100,00](https://www.mercadopago.com/mlb/checkout/start?pref_id=192719033-6a1a0129-cee7-43d5-b2a9-7afa32e15abe) /
[Doar  R$ 50,00](https://www.mercadopago.com/mlb/checkout/start?pref_id=192719033-55dc62ab-7759-4483-9c10-b05bf4e59377) /
[Doar  R$ 20,00](https://www.mercadopago.com/mlb/checkout/start?pref_id=192719033-4a653d99-2493-4d75-8a42-7a2224ad703b) /
[Doar  R$ 10,00](https://www.mercadopago.com/mlb/checkout/start?pref_id=192719033-5dd6ed08-5c8b-4f47-8cd4-df0c573870f1) 