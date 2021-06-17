require 'rails_helper'

describe 'Price history saves automatic' do
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
    product = ClientProduct.create!(name: 'Curso de Café', 
                          price: '20.00', 
                          pix_discount: 5, 
                          card_discount: 5, 
                          boleto_discount: 2,
                          client_company_id: client_company.id)
    
    login_as user, scope: :user
    visit user_root_path
    click_on 'Produtos'
    click_on 'Curso de Café'
    click_on 'Editar'
    fill_in 'Nome', with: 'Curso de Chá'
    fill_in 'Preço', with: '10.00'
    fill_in 'Desconto do Pix', with: '10.20'
    fill_in 'Desconto do Cartão', with: '2'
    fill_in 'Desconto do Boleto', with: '4'
    click_on 'Atualizar Produto'

    expect(PriceHistory.last.price).to eq(10.0)
    expect(PriceHistory.last.client_product_id).to eq(product.id)
    expect(PriceHistory.last.created_at.to_date).to eq(product.created_at.to_date)
  end
end