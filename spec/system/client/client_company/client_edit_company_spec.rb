require 'rails_helper'

describe 'Client edits company' do
  it 'successfully' do
    client_company = ClientCompany.create!(cnpj: '11111111111111', 
                          name: 'Empresa teste', 
                          billing_address: 'Endereço teste',
                          billing_email: 'email@email.com', 
                          admin: 'teste@teste.com')
    user = User.create!(email: 'teste@teste.com', password: '123456', roles: :admin, client_company_id: client_company.id)
    
    
    login_as user, scope: :user
    visit user_root_path
    click_on 'Dados da empresa'
    click_on 'Editar'
    fill_in 'CNPJ', with: '11111111000101'
    fill_in 'Razão social', with: 'Empresa de teste'
    fill_in 'Endereço de cobrança', with: 'Endereço da empresa'
    fill_in 'Email de cobrança', with: 'email@codeplay.com'
    click_on 'Atualizar Empresa'

    expect(page).to have_content('11111111000101')
    expect(page).to have_content('Empresa de teste')
    expect(page).to have_content('Endereço da empresa')
    expect(page).to have_content('email@codeplay.com')
    expect(page).to have_content('teste@teste.com')
    expect(page).to have_link('Voltar', href: root_path)


  end

  it 'cannot be blank' do
    client_company = ClientCompany.create!(cnpj: '11111111111111', 
                          name: 'Empresa teste', 
                          billing_address: 'Endereço teste',
                          billing_email: 'email@email.com', 
                          admin: 'teste@teste.com')
    user = User.create!(email: 'teste@teste.com', password: '123456', roles: :admin, client_company_id: client_company.id)

    login_as user, scope: :user
    visit user_root_path
    click_on 'Dados da empresa'
    click_on 'Editar'
    fill_in 'CNPJ', with: ''
    fill_in 'Razão social', with: ''
    fill_in 'Endereço de cobrança', with: ''
    fill_in 'Email de cobrança', with: ''
    click_on 'Atualizar Empresa'

    expect(page).to have_content('não pode ficar em branco', count: 4)
  end
end