require 'rails_helper'

describe 'Client creates company' do
  it 'successfully' do
    user = User.create!(email: 'teste@codeplay.com', password: '123456', roles: :service)

    login_as user, scope: :user
    visit user_root_path
    click_on 'Cadastrar dados da empresa'
    fill_in 'CNPJ', with: '11111111000101'
    fill_in 'Razão social', with: 'Empresa de teste'
    fill_in 'Endereço de cobrança', with: 'Endereço da empresa'
    fill_in 'Email de cobrança', with: 'email@codeplay.com'
    click_on 'Cadastrar Empresa'

    expect(page).to have_content('11111111000101')
    expect(page).to have_content('Empresa de teste')
    expect(page).to have_content('Endereço da empresa')
    expect(page).to have_content('email@codeplay.com')
    expect(page).to have_content(user.id)
    expect(page).to have_content('codeplay.com')
    expect(page).to have_link('Voltar', href: root_path)

  end

  it 'All fields must be filled' do
    user = User.create!(email: 'teste@teste.com', password: '123456')

    login_as user, scope: :user
    visit user_root_path
    click_on 'Cadastrar dados da empresa'
    click_on 'Cadastrar Empresa'

    expect(page).to have_content('não pode ficar em branco', count: 4)
  end

  it 'cnpj must be uniq' do
    ClientCompany.create!(cnpj: '11111111111111', 
                          name: 'Empresa teste', 
                          billing_address: 'Endereço teste',
                          billing_email: 'email@email.com', 
                          domain: 'teste.com')
    user = User.create!(email: 'teste@teste.com', password: '123456')

    login_as user, scope: :user
    visit new_user_client_company_path
    fill_in 'CNPJ', with: '11111111111111'
    click_on 'Cadastrar Empresa'

    expect(page).to have_content('já está em uso')
  end

  it 'must be loged in' do
    visit user_root_path

    expect(current_path).to eq(new_user_session_path)
  end
end