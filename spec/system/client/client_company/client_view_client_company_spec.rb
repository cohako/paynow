require 'rails_helper'

describe 'Client view company' do
  it 'successfully' do
    client_company = ClientCompany.create!(cnpj: '11111111111111', 
                          name: 'Empresa teste', 
                          billing_address: 'Endereço teste',
                          billing_email: 'email@email.com', 
                          domain: 'teste.com')

    user = User.create!(email: 'teste@teste.com', password: '123456', roles: :admin, client_company_id: client_company.id)

    login_as user, scope: :user
    visit user_client_company_path(client_company.token)
    
    expect(page).to have_content(user.id)
    expect(page).to have_content(client_company.token)
    expect(page).to have_content('Endereço teste')
    expect(page).to have_content('email@email.com')
    expect(page).to have_content('Empresa teste')
  end
end