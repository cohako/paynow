require 'rails_helper'

describe 'Client register product' do
  it 'successfully' do
    client_company = ClientCompany.create!(cnpj: '11111111111111', 
      name: 'Empresa teste', 
      billing_address: 'Endereço teste',
      billing_email: 'email@email.com', 
     
      domain: 'teste.com')
    user = User.create!(email: 'teste@teste.com', 
                        password: '123456', 
                        roles: :admin, 
                        client_company_id: client_company.id)
    
    login_as user, scope: :user
    visit user_root_path
    click_on 'Produtos'
    click_on 'Cadastrar produto'
    fill_in 'Nome', with: 'Curso de Chá'
    fill_in 'Preço', with: '10.00'
    fill_in 'Desconto do Pix', with: '10.20'
    fill_in 'Desconto do Cartão', with: '2'
    fill_in 'Desconto do Boleto', with: '4'
    click_on 'Cadastrar Produto'

    expect(page).to have_content('Curso de Chá')
    expect(page).to have_content('R$ 10,00')
    expect(page).to have_content('10,20%')
    expect(page).to have_content('2,00%')
    expect(page).to have_content('4,00%')
    expect(page).to have_link('Voltar', href: user_client_company_client_products_path(client_company.token))
  end

  it 'and cannot be blank' do
    client_company = ClientCompany.create!(cnpj: '11111111111111', 
      name: 'Empresa teste', 
      billing_address: 'Endereço teste',
      billing_email: 'email@email.com', 
     
      domain: 'teste.com')
    user = User.create!(email: 'teste@teste.com', 
                        password: '123456', 
                        roles: :admin, 
                        client_company_id: client_company.id)
    
    login_as user, scope: :user
    visit user_root_path
    click_on 'Produtos'
    click_on 'Cadastrar produto'
    click_on 'Cadastrar Produto'

    expect(page).to have_content('não pode ficar em branco', count: 5)

  end

end