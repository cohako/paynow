require 'rails_helper'

describe 'Client must create company' do
  it '' do
    client_company = ClientCompany.create!(cnpj: '11111111111111', 
      name: 'Empresa teste', 
      billing_address: 'Endereço teste',
      billing_email: 'email@email.com', 
     
      domain: 'teste.com')
    user = User.create!(email: 'teste@testa.com', 
                        password: '123456', 
                        roles: :admin)

    login_as user, scope: :user
    visit user_client_company_path(client_company)

    expect(current_path).to eq(user_root_path)
  end
end