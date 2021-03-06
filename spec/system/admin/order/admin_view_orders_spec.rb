require 'rails_helper'

describe "Admin view orders " do
  it 'successfully' do
    client_company = ClientCompany.create!(cnpj: '11111111111111', 
                          name: 'CodePlay ltda', 
                          billing_address: 'Endereço empresa',
                          billing_email: 'email@email.com', 
                          
                          domain: 'teste.com')
    product = ClientProduct.create!(name: 'Curso de Café', 
                        price: '20.00', 
                        pix_discount: 5, 
                        card_discount: 5, 
                        boleto_discount: 2,
                        client_company_id: client_company.id)
    payment_method = PaymentMethod.create!(name: 'Pix Vermelho', 
                        payment_type: :pix, 
                        payment_fee: '2,4', 
                        max_monetary_fee: '50,54')
    pix_account = PixAccount.create!(pix_code: 11111111111111111111, 
                          client_company_id: client_company.id,
                          payment_method_id: payment_method.id)
    client_external = ClientExternal.create!(name: 'Testildo', cpf: 11111111111)
    client_external1 = ClientExternal.create!(name: 'Testildes', cpf: 11111111123)
    order = Order.create!(payment_type: :pix,
                          payment_id: pix_account.id,
                          client_company_id: client_company.id,
                          company_token: client_company.token,
                          client_product_id: product.id,
                          product_token: product.product_token,
                          client_external_id: client_external.id,
                          client_token: client_external.client_external_token,
                          price: product.price,
                          price_discounted: 19,
                          due_date: 2.days.from_now
                          )
    order1 = Order.create!(payment_type: :pix,
                          payment_id: pix_account.id,
                          client_company_id: client_company.id,
                          company_token: client_company.token,
                          client_product_id: product.id,
                          product_token: product.product_token,
                          client_external_id: client_external1.id,
                          client_token: client_external1.client_external_token,
                          price: product.price,
                          price_discounted: 19,
                          due_date: 5.days.from_now
                          )
    admin = Admin.create!(email: 'admin@paynow.com', password: 123456)

    login_as admin, scope: :admin
    visit admin_root_path
    click_on 'CodePlay ltda'


    expect(page).to have_content('Curso de Café')
    expect(page).to have_content(order.order_token)
    expect(page).to have_content(client_external.cpf)
    expect(page).to have_content('Curso de Café')
    expect(page).to have_content(order1.order_token)
    expect(page).to have_content(client_external1.cpf)
  end

  it 'and no order around' do
    client_company = ClientCompany.create!(cnpj: '11111111111111', 
                          name: 'CodePlay ltda', 
                          billing_address: 'Endereço empresa',
                          billing_email: 'email@email.com', 
                          
                          domain: 'teste.com')
    product = ClientProduct.create!(name: 'Curso de Café', 
                          price: '20.00', 
                          pix_discount: 5, 
                          card_discount: 5, 
                          boleto_discount: 2,
                          client_company_id: client_company.id)
    payment_method = PaymentMethod.create!(name: 'Pix Vermelho', 
                          payment_type: :pix, 
                          payment_fee: '2,4', 
                          max_monetary_fee: '50,54')
    pix_account = PixAccount.create!(pix_code: 11111111111111111111, 
                            client_company_id: client_company.id,
                            payment_method_id: payment_method.id)
    client_external = ClientExternal.create!(name: 'Testildo', cpf: 11111111111)
    admin = Admin.create!(email: 'admin@paynow.com', password: 123456)

    login_as admin, scope: :admin
    visit admin_root_path
    click_on 'CodePlay ltda'

    expect(page).to have_content('Nenhum cobrança cadastrada')
  end
end