require 'rails_helper'

describe 'Admin rejects order payment' do
  it 'successfuly' do
    client_company = ClientCompany.create!(cnpj: '11111111111111', 
      name: 'CodePlay ltda', 
      billing_address: 'Endereço empresa',
      billing_email: 'email@email.com', 
      admin: 'teste@teste.com',
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
    admin = Admin.create!(email: 'teste@teste.com', password: 123456)

    login_as admin, scope: :admin
    visit admin_root_path
    click_on 'CodePlay ltda'
    click_on order.order_token
    click_on 'Pagamento rejeitado'
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
end