require 'rails_helper'

describe 'Visitor view receipt' do
  it 'successfully' do
    client_company = ClientCompany.create!(cnpj: '11111111111111', 
                                          name: 'CodePlay ltda', 
                                          billing_address: 'Endereço empresa',
                                          billing_email: 'email@email.com', 
                                          
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
                          due_date: 5.days.from_now
          )
    receipt = Receipt.create!(payment_date: Date.today, auth_code: 418, order: order)

    visit root_path
    fill_in 'Código do Recibo', with: receipt.receipt_token
    click_on 'Visualizar'

    expect(page).to have_content(client_company.name)
    expect(page).to have_content(client_company.cnpj)
    expect(page).to have_content(product.name)
    expect(page).to have_content(order.due_date)
    expect(page).to have_content('R$ 19,00')
  end
  it 'token donot exist' do
    client_company = ClientCompany.create!(cnpj: '11111111111111', 
                                          name: 'CodePlay ltda', 
                                          billing_address: 'Endereço empresa',
                                          billing_email: 'email@email.com', 
                                          
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
                          due_date: 5.days.from_now
          )

    visit root_path
    fill_in 'Código do Recibo', with: 'dlfkaçsdjfçkaljsfçlkj'
    click_on 'Visualizar'

    expect(page).to have_content('Recibo não encontrado, favor verificar código utilizado')
  end
end