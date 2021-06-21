client_company = ClientCompany.create!(cnpj: '11111111111111', 
                                      name: 'Empresa teste', 
                                      billing_address: 'Endereço teste',
                                      billing_email: 'email@email.com', 
                                      admin: 'teste@teste.com',
                                      domain: 'teste.com')
client_company.token = 'aaaaaaaaaaaaaaaaaaaa'
client_company.save!

product = ClientProduct.create!(name: 'Curso de Café', 
                                price: '20.00', 
                                pix_discount: 5, 
                                card_discount: 5, 
                                boleto_discount: 2,
                                client_company_id: client_company.id)
product.product_token = 'aaaaaaaaaaaaaaaaaaaa'
product.save!

payment_method = PaymentMethod.create!(name: 'Pix Vermelho', 
  payment_type: :pix, 
  payment_fee: '2,4', 
  max_monetary_fee: '50,54')

pix_account = PixAccount.create!(pix_code: 11111111111111111111, 
    client_company_id: client_company.id,
    payment_method_id: payment_method.id)

client_external = ClientExternal.create!(name: 'Teste', cpf: 11111111111)
client_external.client_external_token = 'aaaaaaaaaaaaaaaaaaaa'
client_external.save!

order = Order.create!(payment_type: :pix,
    payment_id: pix_account.id,
    client_company_id: client_company.id,
    company_token: client_company.token,
    client_product_id: product.id,
    product_token: product.product_token,
    client_external_id: client_external.id,
    client_token: client_external.client_external_token,
    price: product.price,
    price_discounted: 19
    )
order.order_token = 'aaaaaaaaaaaaaaaaaaaa'
order.save!

Admin.create!(email: 'admin@paynow.com', password: '123456')