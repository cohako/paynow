require 'rails_helper'

describe 'Client external API' do
  context 'Post /api/v1/clientexternal' do
    it 'should create a external client' do
      client_company = ClientCompany.create!(cnpj: '11111111111112', 
                          name: 'Empresa teste', 
                          billing_address: 'Endereço teste',
                          billing_email: 'email@email.com', 
                         
                          domain: 'teste.com')
      
      post '/api/v1/client_externals', params: {
                                        client_external: {
                                        name: 'Testildo da testa testado', 
                                        cpf: '12345678932'
                                        }, 
                                        client_company_token: client_company.token
                                      }

      expect(response).to have_http_status(201)
      expect(response.content_type).to include('application/json')
      expect(parsed_body['message']).to eq('Cliente criado com sucesso')
      expect(ClientExternal.last.client_companies).to include(ClientCompany.last)
    end

    it 'if external client exist associat to company' do
      client_company = ClientCompany.create!(cnpj: '11111111111111', 
                          name: 'Empresa teste', 
                          billing_address: 'Endereço teste',
                          billing_email: 'email@email.com', 
                         
                          domain: 'teste.com')

      ClientExternal.create!(name: 'Testildo da testa testado', cpf: 12345678932)

      post '/api/v1/client_externals', params: {
                                        client_external: {
                                          name: 'Testildo da testa testado', 
                                          cpf: '12345678932'
                                        }, 
                                        client_company_token: client_company.token
                                      }

      expect(response).to have_http_status(201)
      expect(response.content_type).to include('application/json')
      expect(parsed_body['message']).to eq('Cliente criado com sucesso')
      expect(ClientExternal.last.client_companies).to include(ClientCompany.last)
      expect(ClientExtCompany.count).to eq(1)
    end

    it 'name and cpf must be present' do
      client_company = ClientCompany.create!(cnpj: '11111111111111', 
                          name: 'Empresa teste', 
                          billing_address: 'Endereço teste',
                          billing_email: 'email@email.com', 
                         
                          domain: 'teste.com')
      post '/api/v1/client_externals', params: {
                                        client_external: {name: '',
                                                          cpf: ''
                                        }, 
                                        client_company_token: client_company.token
                                      }

      expect(response).to have_http_status(:unprocessable_entity)
      expect(response.content_type).to include('application/json')
      expect(response.body).to include("Nome não pode ficar em branco")
      expect(response.body).to include("Cpf não pode ficar em branco")
    end
  end
  
  it 'cpf should have 11 chars' do
    client_company = ClientCompany.create!(cnpj: '11111111111111', 
                        name: 'Empresa teste', 
                        billing_address: 'Endereço teste',
                        billing_email: 'email@email.com', 
                       
                        domain: 'teste.com')
    post '/api/v1/client_externals', params: {
                                      client_external: {name: 'Teste',
                                                        cpf: '123'
                                      }, 
                                      client_company_token: client_company.token
                                    }

    expect(response).to have_http_status(:unprocessable_entity)
    expect(response.content_type).to include('application/json')
    expect(response.body).to include("Cpf não possui o tamanho esperado (11 caracteres)")
  end

  it 'params cannot be missing' do
    client_company = ClientCompany.create!(cnpj: '11111111111111', 
                        name: 'Empresa teste', 
                        billing_address: 'Endereço teste',
                        billing_email: 'email@email.com', 
                       
                        domain: 'teste.com')
    post '/api/v1/client_externals', params: {client_external: {}
                                    }

    expect(response).to have_http_status(404)

  end
end