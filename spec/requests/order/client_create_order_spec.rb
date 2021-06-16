require 'rails_helper'

describe 'Order API' do
  context 'Post /api/v1/order' do
    it 'should create a external client' do
      client_company = ClientCompany.create!(cnpj: '11111111111111', 
                          name: 'Empresa teste', 
                          billing_address: 'Endereço teste',
                          billing_email: 'email@email.com', 
                          admin: 'teste@teste.com',
                          domain: 'teste.com')
      post '/api/v1/orders', params: {
                                        order: {
                                        name: 'Testildo da testa testado', 
                                        cpf: '12345678932'
                                        }, 
                                        client_company_token: client_company.token
                                      }

      expect(response).to have_http_status(201)
      expect(response.content_type).to include('application/json')
      expect(parsed_body['name']).to eq('Testildo da testa testado')
      expect(parsed_body['cpf']).to eq(12345678932)
      expect(ClientExternal.last.client_companies).to include(ClientCompany.last)
    end