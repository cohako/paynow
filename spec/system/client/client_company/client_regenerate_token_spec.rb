require 'rails_helper'

describe 'Client regenerate company token' do
  it 'successfully' do
    client_company = ClientCompany.create!(cnpj: '11111111111111', 
                          name: 'Empresa teste', 
                          billing_address: 'Endereço teste',
                          billing_email: 'email@email.com', 
                         
                          domain: 'teste.com')
    user = User.create!(email: 'teste@teste.com', password: '123456', roles: :admin, client_company_id: client_company.id)
    login_as user, scope: :user
    visit user_client_company_path(client_company.token)
    click_on 'Trocar token'
    
    expect(page).to_not have_content('11111111111111111111')

  end

  it 'and must be admin' do
    client_company = ClientCompany.create!(cnpj: '11111111111111', 
                          name: 'Empresa teste', 
                          billing_address: 'Endereço teste',
                          billing_email: 'email@email.com', 
                         
                          domain: 'teste.com')
    user = User.create!(email: 'teste@teste.com', password: '123456', client_company_id: client_company.id)

    login_as user, scope: :user
    visit user_client_company_path(client_company.token)
    click_on 'Trocar token'
    
    expect(page).to have_content(client_company.token)
    expect(page).to have_content('Somente o usuário administrador pode realizar essa ação')
  end
end