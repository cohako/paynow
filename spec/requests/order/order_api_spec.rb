require 'rails_helper'

describe 'Order API' do
  context 'Post /api/v1/order' do
    it 'should create a pix order' do
      client_company = ClientCompany.create!(cnpj: '11111111111111', 
        name: 'Empresa teste', 
        billing_address: 'Endereço teste',
        billing_email: 'email@email.com', 
        admin: 'teste@teste.com',
        domain: 'teste.com')
        product = ClientProduct.create!(name: 'Curso de Café', 
          price: '20.00', 
          pix_discount: 5, 
          card_discount: 5, 
          boleto_discount: 2,
          client_company_id: client_company.id)
          payment_method = PaymentMethod.create!(name: 'Pix Vermelho', 
            payment_type: :pix, 
            payment_fee: '2,4', 
            max_monetary_fee: '50,54')
            pix_account = PixAccount.create!(pix_code: 11111111111111111111, 
              client_company_id: client_company.id,
              payment_method_id: payment_method.id)
              client_external = ClientExternal.create!(name: 'Teste', cpf: 11111111111)
              
              post '/api/v1/orders', 
              params: {
                order: 
                {
                  payment_type: :pix,
                  payment_id: pix_account.id,
                  company_token: client_company.token,
                  product_token: product.product_token,
                  client_token: client_external.client_external_token,
                }
              }
              
      expect(response).to have_http_status(201)              
      expect(response.content_type).to include('application/json')              
      expect(parsed_body['price_discounted']).to eq("19.0")
      expect(parsed_body['price']).to eq("20.0")
      expect(parsed_body['status']).to eq('pendente')
      expect(parsed_body['payment_type']).to eq('pix')
      expect(parsed_body['company_token']).to eq(client_company.token)
      expect(parsed_body['client_token']).to eq(client_external.client_external_token)
      expect(parsed_body['product_token']).to eq(product.product_token)
      
    end
    it 'should create a boleto order' do
      client_company = ClientCompany.create!(cnpj: '11111111111111', 
                          name: 'Empresa teste', 
                          billing_address: 'Endereço teste',
                          billing_email: 'email@email.com', 
                          admin: 'teste@teste.com',
                          domain: 'teste.com')
      product = ClientProduct.create!(name: 'Curso de Café', 
                          price: '20.00', 
                          pix_discount: 5, 
                          card_discount: 5, 
                          boleto_discount: 2,
                          client_company_id: client_company.id)
      payment_method = PaymentMethod.create!(name: 'Pix Vermelho', 
                          payment_type: :boleto, 
                          payment_fee: '2,4', 
                          max_monetary_fee: '50,54')
      boleto_account = BoletoAccount.create!(bank_code: 418, 
                          agency_code: 11122, 
                          account_number: 123654, 
                          client_company_id: client_company.id,
                          payment_method_id: payment_method.id)
      client_external = ClientExternal.create!(name: 'Teste', cpf: 11111111111)

      post '/api/v1/orders', 
            params: {
                      order: 
                      {
                        payment_type: :boleto,
                        payment_id: boleto_account.id,
                        company_token: client_company.token,
                        product_token: product.product_token,
                        client_token: client_external.client_external_token,
                        boleto_address: 'Endereço',
                        due_date: 5.days.from_now
                      }
                    }

      expect(response).to have_http_status(201)              
      expect(response.content_type).to include('application/json')              
      expect(parsed_body['price_discounted']).to eq("19.6")
      expect(parsed_body['price']).to eq("20.0")
      expect(parsed_body['status']).to eq('pendente')
      expect(parsed_body['payment_type']).to eq('boleto')
      expect(Order.last.boleto_address).to eq('Endereço')
      expect(parsed_body['company_token']).to eq(client_company.token)
      expect(parsed_body['client_token']).to eq(client_external.client_external_token)
      expect(parsed_body['product_token']).to eq(product.product_token)
      
    end
    it 'should create a card order' do
      client_company = ClientCompany.create!(cnpj: '11111111111111', 
                          name: 'Empresa teste', 
                          billing_address: 'Endereço teste',
                          billing_email: 'email@email.com', 
                          admin: 'teste@teste.com',
                          domain: 'teste.com')
      product = ClientProduct.create!(name: 'Curso de Café', 
                          price: '20.00', 
                          pix_discount: 5, 
                          card_discount: 14, 
                          boleto_discount: 2,
                          client_company_id: client_company.id)
      payment_method = PaymentMethod.create!(name: 'Pix Vermelho', 
                          payment_type: :cartao, 
                          payment_fee: '2,4', 
                          max_monetary_fee: '50,54')
      card_account = CardAccount.create!(contract_number: 1111111111111, 
                            client_company_id: client_company.id,
                            payment_method_id: payment_method.id)
      client_external = ClientExternal.create!(name: 'Teste', cpf: 11111111111)

      post '/api/v1/orders', 
            params: {
                      order: 
                      {
                        payment_type: :cartao,
                        payment_id: card_account.id,
                        company_token: client_company.token,
                        product_token: product.product_token,
                        client_token: client_external.client_external_token,
                        card_number: 12312131,
                        print_name: 'Murilo',
                        card_cvv: 123,
                        due_date: 5.days.from_now
                      }
                    }

      expect(response).to have_http_status(201)              
      expect(response.content_type).to include('application/json')              
      expect(parsed_body['price_discounted']).to eq("17.2")
      expect(parsed_body['price']).to eq("20.0")
      expect(parsed_body['status']).to eq('pendente')
      expect(parsed_body['payment_type']).to eq('cartao')
      expect(parsed_body['company_token']).to eq(client_company.token)
      expect(parsed_body['client_token']).to eq(client_external.client_external_token)
      expect(parsed_body['product_token']).to eq(product.product_token)
      expect(Order.last.card_number).to eq(12312131)
      expect(Order.last.print_name).to eq('Murilo')
      expect(Order.last.card_cvv).to eq(123)
      
    end

    it 'attributes cannot be blank' do
      client_company = ClientCompany.create!(cnpj: '11111111111111', 
                          name: 'Empresa teste', 
                          billing_address: 'Endereço teste',
                          billing_email: 'email@email.com', 
                          admin: 'teste@teste.com',
                          domain: 'teste.com')
      product = ClientProduct.create!(name: 'Curso de Café', 
                          price: '20.00', 
                          pix_discount: 5, 
                          card_discount: 5, 
                          boleto_discount: 2,
                          client_company_id: client_company.id)
      payment_method = PaymentMethod.create!(name: 'Pix Vermelho', 
                          payment_type: :pix, 
                          payment_fee: '2,4', 
                          max_monetary_fee: '50,54')
      pix_account = PixAccount.create!(pix_code: 11111111111111111111, 
                            client_company_id: client_company.id,
                            payment_method_id: payment_method.id)
      client_external = ClientExternal.create!(name: 'TEste', cpf: 11111111111)

      post '/api/v1/orders', 
            params: {
                      order: 
                      {
                        payment_type: nil,
                        payment_id: nil,
                        company_token: nil,
                        client_token: nil,
                        client_product: nil
                      }
                    }
      expect(response).to have_http_status(422)              
      expect(response.content_type).to include('application/json') 
      expect(response.body).to include('Compania é obrigatório(a)')             
      expect(response.body).to include('Produto é obrigatório(a)')             
      expect(response.body).to include('Client externo é obrigatório(a)')             
      expect(response.body).to include('Token do client não pode ficar em branco')             
      expect(response.body).to include('Token do produto não pode ficar em branco')             
      expect(response.body).to include('Método de pagamento não pode ficar em branco')   
      expect(response.body).to include('Preço não pode ficar em branco') 
    end
    it 'not found if company donot existe' do
      client_external = ClientExternal.create!(name: 'TEste', cpf: 11111111111)

      post '/api/v1/orders', 
            params: {
                      order: 
                      {
                        payment_type: :pix,
                        payment_id: SecureRandom.base58(20),
                        company_token: SecureRandom.base58(20),
                        product_token: SecureRandom.base58(20),
                        client_token: SecureRandom.base58(20)
                      }
                    }
      expect(response).to have_http_status(422)              
      expect(response.content_type).to include('application/json') 
    end

    it 'and params cannot be missing' do
      client_external = ClientExternal.create!(name: 'TEste', cpf: 11111111111)

      post '/api/v1/orders', 
            params: {
                      order: 
                      {
                      }
                    }
      expect(response).to have_http_status(406)              
      expect(response.content_type).to include('application/json')
      expect(response.body).to include("Parâmetros inválidos")
      
    end
  end
  context 'GET /api/v1/orders/:order_token' do
    it 'should show uniq order' do
      client_company = ClientCompany.create!(cnpj: '11111111111111', 
                          name: 'Empresa teste', 
                          billing_address: 'Endereço teste',
                          billing_email: 'email@email.com', 
                          admin: 'teste@teste.com',
                          domain: 'teste.com')
      product = ClientProduct.create!(name: 'Curso de Café', 
                          price: '20.00', 
                          pix_discount: 5, 
                          card_discount: 5, 
                          boleto_discount: 2,
                          client_company_id: client_company.id)
      payment_method = PaymentMethod.create!(name: 'Pix Vermelho', 
                          payment_type: :pix, 
                          payment_fee: '2,4', 
                          max_monetary_fee: '50,54')
      pix_account = PixAccount.create!(pix_code: 11111111111111111111, 
                            client_company_id: client_company.id,
                            payment_method_id: payment_method.id)
      client_external = ClientExternal.create!(name: 'Teste', cpf: 11111111111)
      order = Order.create!(payment_type: :pix,
                            payment_id: pix_account.id,
                            client_company_id: client_company.id,
                            company_token: client_company.token,
                            client_product_id: product.id,
                            product_token: product.product_token,
                            client_external_id: client_external.id,
                            client_token: client_external.client_external_token,
                            price: product.price,
                            price_discounted: 19,
                            due_date: 5.days.from_now
                            )

      get "/api/v1/orders/#{order.order_token}"

      expect(response).to have_http_status(201)              
      expect(response.content_type).to include('application/json')              
      expect(parsed_body['price_discounted']).to eq("19.0")
      expect(parsed_body['price']).to eq("20.0")
      expect(parsed_body['status']).to eq('pendente')
      expect(parsed_body['payment_type']).to eq('pix')
      expect(parsed_body['company_token']).to eq(client_company.token)
      expect(parsed_body['client_token']).to eq(client_external.client_external_token)
      expect(parsed_body['product_token']).to eq(product.product_token)
    end

    it 'should got 404 with wrong param' do

      get "/api/v1/orders/:412341234"

        expect(response).to have_http_status(404)              
    end
  end

  context 'GET /api/v1/orders/' do
    it 'should show orders' do

      client_company = ClientCompany.create!(cnpj: '11111111111111', 
                          name: 'Empresa teste', 
                          billing_address: 'Endereço teste',
                          billing_email: 'email@email.com', 
                          admin: 'teste@teste.com',
                          domain: 'teste.com')

      product = ClientProduct.create!(name: 'Curso de Café', 
                          price: 20.00, 
                          pix_discount: 5, 
                          card_discount: 5, 
                          boleto_discount: 10,
                          client_company_id: client_company.id)
      product2 = ClientProduct.create!(name: 'Curso de Ruby', 
                          price: 25.00, 
                          pix_discount: 20, 
                          card_discount: 5, 
                          boleto_discount: 2,
                          client_company_id: client_company.id)

      payment_method = PaymentMethod.create!(name: 'Pix Vermelho', 
                          payment_type: :pix, 
                          payment_fee: '2,4', 
                          max_monetary_fee: '50,54')

      pix_account = PixAccount.create!(pix_code: 11111111111111111111, 
                            client_company_id: client_company.id,
                            payment_method_id: payment_method.id)
      boleto_account = BoletoAccount.create!(bank_code: 418, 
                          agency_code: 11122, 
                          account_number: 123654, 
                          client_company_id: client_company.id,
                          payment_method_id: payment_method.id)

      client_external = ClientExternal.create!(name: 'Teste', cpf: 11111111111)

      Order.create!(payment_type: :pix,
                            payment_id: pix_account.id,
                            client_company_id: client_company.id,
                            company_token: client_company.token,
                            client_product_id: product2.id,
                            product_token: product2.product_token,
                            client_external_id: client_external.id,
                            client_token: client_external.client_external_token,
                            price: product.price,
                            price_discounted: 20,
                            due_date: 5.days.from_now
                            )
      Order.create!(payment_type: :boleto,
                            payment_id: boleto_account.id,
                            client_company_id: client_company.id,
                            company_token: client_company.token,
                            client_product_id: product.id,
                            product_token: product.product_token,
                            client_external_id: client_external.id,
                            client_token: client_external.client_external_token,
                            price: product.price,
                            price_discounted: 18,
                            boleto_address: 'Endereço',
                            due_date: 5.days.from_now
                            )

      get "/api/v1/orders/", params: 
        {
          company_token: client_company.token
        }


      expect(response).to have_http_status(201)              
      expect(response.content_type).to include('application/json')              
      expect(parsed_body[0]['price_discounted']).to eq("20.0")
      expect(parsed_body[0]['price']).to eq("20.0")
      expect(parsed_body[0]['status']).to eq('pendente')
      expect(parsed_body[0]['payment_type']).to eq('pix')
      expect(parsed_body[0]['company_token']).to eq(client_company.token)
      expect(parsed_body[0]['client_token']).to eq(client_external.client_external_token)
      expect(parsed_body[0]['product_token']).to eq(product2.product_token)
      expect(parsed_body[1]['price_discounted']).to eq("18.0")
      expect(parsed_body[1]['price']).to eq("20.0")
      expect(parsed_body[1]['status']).to eq('pendente')
      expect(parsed_body[1]['payment_type']).to eq('boleto')
      expect(parsed_body[1]['company_token']).to eq(client_company.token)
      expect(parsed_body[1]['client_token']).to eq(client_external.client_external_token)
      expect(parsed_body[1]['product_token']).to eq(product.product_token)

    end

    it 'should got 404 with params missing' do

      get "/api/v1/orders/", params:{}

        expect(response).to have_http_status(404)              
    end

    it 'should got 404 with wrong param' do

      get "/api/v1/orders/", params:{company_token: 'sdfasdfasdf'}

        expect(response).to have_http_status(404)              
    end
  end
end