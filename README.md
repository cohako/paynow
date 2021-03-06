# Projeto Paynow

*Sobre o projeto*
Uma escola de programação, a CodePlay, decidiu lançar uma plataforma de cursos online de
programação. Você já está trabalhando nesse projeto e agora vamos começar uma nova etapa:
uma ferramenta de pagamentos capaz de configurar os meios de pagamentos e registrar as
cobranças referentes a cada venda de curso na CodePlay. O objetivo deste projeto é construir
o mínimo produto viável (MVP) dessa plataforma de pagamentos.
Na plataforma de pagamentos temos dois perfis de usuários: os administradores da plataforma
e os donos de negócios que querem vender seus produtos por meio da plataforma, como as
pessoas da CodePlay, por exemplo. Os administradores devem cadastrar os meios de
pagamento disponíveis, como boletos bancários, cartões de crédito, PIX etc, especificando
detalhes de cada formato. Administradores também podem consultar os clientes da plataforma,
consultar e avaliar solicitações de reembolso, bloquear compras por suspeita de fraudes etc.
Já os donos de negócios devem ser capazes de cadastrar suas empresas e ativar uma conta
escolhendo quais meios de pagamento serão utilizados. Devem ser cadastrados também os
planos disponíveis para venda, incluindo seus valores e condições de desconto de acordo com
o meio de pagamento. E a cada nova venda realizada, devem ser armazenados dados do
cliente, do produto selecionado e do meio de pagamento escolhido. Um recibo deve ser emitido
para cada pagamento e esse recibo deve ser acessível para os clientes finais, alunos da
CodePlay no nosso contexto.

### Configurações
* Ruby 3.0.1
* Rails 6.1.3.2
## Gems
* Testes:
  - Rspec
  - Capybara
* Bootstrap

### Banco de dados
* O desenho do banco de dados pode ser encontrado no link:
  - https://drive.google.com/drive/folders/1GPoT8bOIzscFayNOh0cuEY9THDchlI2m?usp=sharing

### Iniciando o projeto em sua máquina 
* Primeiro clone o projeto:
  ```
  git clone git@github.com:cohako/paynow.git
  ```
* Entre na pasta:
  ```
  cd ./paynow
  ```
* Abra o terminal e rode:
  ```
  bin/setup
  ```
* Para popular o banco do servidor, rode:
  ```
  rails db:seed
  ```
* Após a instalação de todas as dependências o projeto já está pronto para uso
### Testes
* Para rodar os testes com descrição de tarefa, rode: ```rspec -fd```
* Para rodar somente os testes: ```rspec```

### Dados técnicos
## Administrador
* Administradores **obrigatoriamente** possuir um e-mail com o dominio @paynow.com.br.
- Para realizar o login basta clicar em ``` Sign In Admin ```

- Alguns administradores já cadastrados são:
  - email: admin@paynow.com senha: 123456

### Usuário
* Usuários não podem se registrar com emails de dominio público, como **Google**
  - Para realizar o login basta clicar em ``` Sign In User ```

- Alguns administradores já cadastrados são:
  - email: user@codeplay.com senha: 123456
  - email: user1@codeplay.com senha: 123456
  - email: user@coldplay.com senha: 123456
  - email: user1@coldplay.com senha: 123456

## API
### Registro de cliente final
#### __post '/api/v1/client_external'__
* o endpoint para criação e associação de um cliente externo e uma empresa cliente PayNow, espera receber os seguintes parâmetros:
```
{
	"client_external":
	{
		"name": "Nome de teste",
		"cpf": "11111111111"
	},
	"client_company_token": 'Token de empresa já cadastrado com 20 chars 
	(para teste foi populada uma empresa com token aaaaaaaaaaaaaaaaaaaa')
}
```
#### Possíveis Respostas
* HTTP Status: 201 

Exemplo:
```
{
  "message": "Cliente criado com sucesso"
}
```
* HTTP Status: 412 - Parâmetros inválidos para criação de cliente (parametros em branco ou não respeitando as validações)

* HTTP Status: 412 - Token Inválido

* HTTP Status: 404 - Not Found


#### __post '/api/v1/orders'__
* o endpoint para criação de cobrança:

```
{
	"order": 
	{
		"payment_type": "dado" de enum :pix, :boleto ou :cartao,
		"payment_id": "ID" de método de pagamento,
		"company_token": "Token" de empresa já cadastrado com 20 chars,
		(para teste foi populada uma empresa com token aaaaaaaaaaaaaaaaaaaa')
		"product_token": "token" do produto,
		(para teste foi populado um produto com token aaaaaaaaaaaaaaaaaaaa')
		"client_token": "Token" do cliente external
		(para teste foi populado um client com token aaaaaaaaaaaaaaaaaaaa')
	}
}

```
#### Possíveis Respostas
* HTTP Status: 201 

Exemplo:
```
  {
    "price": "27.0",
    "price_discounted": "19.0",
    "payment_type": "pix",
    "status": "pendente",
    "company_token": "aaaaaaaaaaaaaaaaaaaa",
    "product_token": "aaaaaaaaaaaaaaaaaaaa",
    "client_token": "aaaaaaaaaaaaaaaaaaaa",
    "order_token": "aaaaaaaaaaaaaaaaaaaa",
    "created_at": "2021-06-22T22:47:43.604Z",
    "payment_id": 2,
    "due_date": "2021-06-27"
  }
```
* HTTP Status: 412 - Parâmetros inválidos para criação de cliente (parametros em branco ou não respeitando as validações)

* HTTP Status: 412 - Token Inválido

* HTTP Status: 404 - Not Found


#### __get '/api/v1/orders'__
* o endpoint para visualização de todas as cobranças:

```
{
	"order": 
  {
	  "company_token": "Token" de empresa já cadastrado com 20 chars,
		(para teste foi populada uma empresa com token aaaaaaaaaaaaaaaaaaaa')
	}
}

```
#### Possíveis Respostas
* HTTP Status: 201 

Exemplo:
```
  {
    "price": "27.0",
    "price_discounted": "19.0",
    "payment_type": "pix",
    "status": "pendente",
    "company_token": "aaaaaaaaaaaaaaaaaaaa",
    "product_token": "aaaaaaaaaaaaaaaaaaaa",
    "client_token": "aaaaaaaaaaaaaaaaaaaa",
    "order_token": "aaaaaaaaaaaaaaaaaaaa",
    "created_at": "2021-06-22T22:47:43.604Z",
    "payment_id": 2,
    "due_date": "2021-06-27"
  }
```
* HTTP Status: 412 - Parâmetros inválidos para criação de cliente (parametros em branco ou não respeitando as validações)

* HTTP Status: 412 - Token Inválido

* HTTP Status: 404 - Not Found

#### __get '/api/v1/orders/:order_token'__
* o endpoint para visualização de cobrança única:

```
	curl localhost:3000/api/v1/orders/aaaaaaaaaaaaaaaaaaaa

```
#### Possíveis Respostas
* HTTP Status: 201 

Exemplo:
```
  {
  "price": "27.0",
  "price_discounted": "19.0",
  "payment_type": "pix",
  "status": "pendente",
  "company_token": "aaaaaaaaaaaaaaaaaaaa",
  "product_token": "aaaaaaaaaaaaaaaaaaaa",
  "client_token": "aaaaaaaaaaaaaaaaaaaa",
  "order_token": "aaaaaaaaaaaaaaaaaaaa",
  "created_at": "2021-06-22T22:47:43.604Z",
  "payment_id": 2,
  "due_date": "2021-06-27"
  }
```
* HTTP Status: 412 - Parâmetros inválidos para criação de cliente (parametros em branco ou não respeitando as validações)

* HTTP Status: 412 - Token Inválido

* HTTP Status: 404 - Not Found
