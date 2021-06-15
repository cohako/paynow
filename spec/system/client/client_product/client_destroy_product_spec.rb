require 'rails_helper'

describe 'Client destrou product' do
  it 'successfully' do
    client_company = ClientCompany.create!(cnpj: '11111111111111', 
                                          name: 'Empresa teste', 
                                          billing_address: 'Endereço teste',
                                          billing_email: 'email@email.com', 
                                          admin: 'teste@teste.com',
                                          domain: 'teste.com')
    user = User.create!(email: 'teste@teste.com', 
                        password: '123456', 
                        roles: :admin, 
                        client_company_id: client_company.id)
    ClientProduct.create!(name: 'Curso de Café', 
                          price: '20.00', 
                          pix_discount: 5, 
                          card_discount: 5, 
                          boleto_discount: 2,
                          client_company_id: client_company.id)

    login_as user, scope: :user
    visit user_root_path
    click_on 'Produtos'
    click_on 'Curso de Café'
    click_on 'Apagar'

    expect(page).to_not have_content('Curso de Café')
  end
end