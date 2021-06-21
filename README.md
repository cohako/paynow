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
* Testes:
  - Rspec
  - Capybara

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

### Usuári
* Usuários não podem se registrar com emails de dominio público, como **Google**
  - Para realizar o login basta clicar em ``` Sign In User ```

- Alguns administradores já cadastrados são:
  - email: user@codeplay.com senha: 123456

## API
### Registro de cliente final
#### __post '/api/v1/client_external'__
* o endpoint para criação e associação de um cliente externo e uma empresa cliente PayNow, espera receber os seguintes parâmetros:
```
{
	'client_external':
	{
		'name': 'Nome de teste',
		'cpf': '11111111111'
	},
	'client_company_token': 'Token de empresa já cadastrado com 20 chars 
	(para teste foi populada uma empresa com token aaaaaaaaaaaaaaaaaaaa')
}
```
#### Possíveis Respostas
* HTTP Status: 201 

Exemplo:
```
{
	name: "John Doe",
	cpf: "11111111111",
	token: "txrzoRCiGngB8Fr6zgKB"
}
```
* HTTP Status: 412 - Parâmetros inválidos para criação de cliente (parametros em branco ou não respeitando as validações)

* HTTP Status: 412 - Token Inválido (da empresa)

#### __post '/api/v1/orders'__
* o endpoint para criação e associação de um cliente externo e uma empresa cliente, espera receber os seguintes parâmetros:

```
{
	order: 
	{
		payment_type: dado de enum :pix, :boleto ou :cartao,
		payment_id: ID de método de pagamento,
		company_token: Token de empresa,
		product_token: token do produto,
		client_token: Token do cliente externl,
	}
}

```
