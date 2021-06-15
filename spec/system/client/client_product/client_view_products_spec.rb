require 'rails_helper'

describe 'client view all products' do
  it 'successfully' do
    client_company = ClientCompany.create!(cnpj: '11111111111111', 
      name: 'Empresa teste', 
      billing_address: 'Endereço teste',
      billing_email: 'email@email.com', 
      admin: 'teste@teste.com',
      domain: 'teste.com')
    client_company2 = ClientCompany.create!(cnpj: '11111111111112', 
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
    ClientProduct.create!(name: 'Curso de chá', 
                          price: '40.00', 
                          pix_discount: 5, 
                          card_discount: 5, 
                          boleto_discount: 2,
                          client_company_id: client_company.id)
    ClientProduct.create!(name: 'Curso de ruby', 
                          price: '10.00', 
                          pix_discount: 5, 
                          card_discount: 5, 
                          boleto_discount: 2,
                          client_company_id: client_company.id)
    ClientProduct.create!(name: 'Curso de ruby on rails', 
                            price: '30.00', 
                            pix_discount: 5, 
                            card_discount: 5, 
                            boleto_discount: 2,
                            client_company_id: client_company2.id)


    login_as user, scope: :user
    visit user_root_path
    click_on 'Produtos'
    
    expect(page).to have_content('Curso de Café')
    expect(page).to have_content('Curso de chá')
    expect(page).to have_content('Curso de ruby')
    expect(page).to have_content('R$ 20,00')
    expect(page).to have_content('R$ 40,00')
    expect(page).to have_content('R$ 10,00')
    expect(page).to_not have_content('Curso de ruby on rails')
    expect(page).to_not have_content('R$ 30,00')
                          
  end
  it 'and there is none' do
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

    login_as user, scope: :user
    visit user_root_path
    click_on 'Produtos'
    
    expect(page).to have_content('Nenhum produto encontrado')
  end
end