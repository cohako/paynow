require 'rails_helper'

describe 'Admin aproves order payment' do
  it 'successfuly' do
    client_company = ClientCompany.create!(cnpj: '11111111111111', 
                                          name: 'CodePlay ltda', 
                                          billing_address: 'Endereço empresa',
                                          billing_email: 'email@email.com', 
                                          admin: 'admin@paynow.com',
                                          domain: 'paynow.com')
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
                          due_date: 5.days.from_now
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
    click_on order.order_token
    click_on 'Aprovar pagamento'
    fill_in 'Data de pagamento', with: "#{1.days.from_now}"
    fill_in 'Código de aprovação', with: 418
    click_on 'Cadastrar Pagamento'
    


    expect(page).to have_content('Curso de Café')
    expect(page).to have_content(418)
    expect(page).to have_content(Receipt.last.receipt_token)
    expect(page).to have_content(Receipt.last.payment_date)
    expect(page).to have_content(order.order_token)
    expect(Order.first.status).to eq('aprovada')
  end

  it 'and cannot be blank' do
    client_company = ClientCompany.create!(cnpj: '11111111111111', 
                                          name: 'CodePlay ltda', 
                                          billing_address: 'Endereço empresa',
                                          billing_email: 'email@email.com', 
                                          admin: 'admin@paynow.com',
                                          domain: 'paynow.com')
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
                          due_date: 5.days.from_now
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
    click_on order.order_token
    click_on 'Aprovar pagamento'
    click_on 'Cadastrar Pagamento'

    expect(page).to have_content('não pode ficar em branco', count: 2)
  end
  it 'view receipt on order' do
    client_company = ClientCompany.create!(cnpj: '11111111111111', 
                                          name: 'CodePlay ltda', 
                                          billing_address: 'Endereço empresa',
                                          billing_email: 'email@email.com', 
                                          admin: 'admin@paynow.com',
                                          domain: 'paynow.com')
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
                          due_date: 5.days.from_now,
                          status: :aprovada
                          )
    admin = Admin.create!(email: 'admin@paynow.com', password: 123456)
    receipt = Receipt.create!(payment_date: 2.days.from_now,
                    auth_code: 418,
                    order_id: order.id)

    login_as admin, scope: :admin
    visit admin_root_path
    click_on 'CodePlay ltda'
    click_on order.order_token
    
    expect(page).to have_content(receipt.auth_code)
    expect(page).to have_content(receipt.payment_date)

  end
end