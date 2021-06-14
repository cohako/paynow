require 'rails_helper'

describe 'Client view company' do
  it 'successfully' do
    client_company = ClientCompany.create!(cnpj: '11111111111111', 
                          name: 'Empresa teste', 
                          billing_address: 'Endereço teste',
                          billing_email: 'email@email.com', 
                          admin: 'teste@teste.com',
                          domain: 'teste.com',
                          token: '11111111111111111111')

    user = User.create!(email: 'teste@teste.com', password: '123456', roles: :admin, client_company_id: client_company.id)

    login_as user, scope: :user
    visit user_client_company_path(client_company.token)
    
    expect(page).to have_content('teste@teste.com')
    expect(page).to have_content('11111111111111111111')
    expect(page).to have_content('Endereço teste')
    expect(page).to have_content('email@email.com')
    expect(page).to have_content('Empresa teste')
  end
end