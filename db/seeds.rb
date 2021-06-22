client_company = ClientCompany.create!(cnpj: '11111111111111', 
                                      name: 'Empresa teste', 
                                      billing_address: 'Endereço teste',
                                      billing_email: 'email@codeplay.com', 
                                      admin: 'admin@codeplay.com',
                                      domain: 'codeplay.com')
client_company.token = 'aaaaaaaaaaaaaaaaaaaa'
client_company.save!

client_company1 = ClientCompany.create!(cnpj: '11111111111112', 
                                      name: 'Empresa teste 2', 
                                      billing_address: 'Endereço teste 2',
                                      billing_email: 'email@coldplay.com', 
                                      admin: 'teste@coldplay.com',
                                      domain: 'coldplay.com')

Admin.create!(email: 'admin@paynow.com', password: '123456')

User.create!(email: 'user@codeplay.com', roles: :admin, password: '123456')
User.create!(email: 'user1@codeplay.com', password: '123456')
User.create!(email: 'user@coldplay.com', roles: :admin,password: '123456')
User.create!(email: 'user1@coldplay.com', password: '123456')

product = ClientProduct.create!(name: 'Curso de chá', 
                                price: '27.00', 
                                pix_discount: 8, 
                                card_discount: 4, 
                                boleto_discount: 3,
                                client_company_id: client_company.id)
product.product_token = 'aaaaaaaaaaaaaaaaaaaa'
product.save!

product1 = ClientProduct.create!(name: 'Curso de Café', 
                                price: '20.00', 
                                pix_discount: 5, 
                                card_discount: 5, 
                                boleto_discount: 2,
                                client_company_id: client_company1.id)

payment_method = PaymentMethod.create!(name: 'Pix Vermelho', 
                                      payment_type: :pix, 
                                      payment_fee: '2,4', 
                                      max_monetary_fee: '50,54')
payment_method1 = PaymentMethod.create!(name: 'Pix Azul', 
                                      payment_type: :pix, 
                                      payment_fee: '2,4', 
                                      max_monetary_fee: '50,54')
payment_boleto = PaymentMethod.create!(name: 'Boleto Vermelho', 
                                      payment_type: :boleto, 
                                      payment_fee: '2,9', 
                                      max_monetary_fee: '55,54')
payment_boleto1 = PaymentMethod.create!(name: 'Boleto preto', 
                                      payment_type: :boleto, 
                                      payment_fee: '2,7', 
                                      max_monetary_fee: '60,54')
payment_card = PaymentMethod.create!(name: 'Boleto Vermelho', 
                                      payment_type: :cartao, 
                                      payment_fee: '2,9', 
                                      max_monetary_fee: '55,54')
payment_card1 = PaymentMethod.create!(name: 'Cartão Rosa', 
                                      payment_type: :cartao, 
                                      payment_fee: '8,7', 
                                      max_monetary_fee: '40,54')

pix_account = PixAccount.create!(pix_code: 11111111111111111111, 
                                client_company_id: client_company.id,
                                payment_method_id: payment_method.id)
pix_account = PixAccount.create!(pix_code: 11111111111111111144, 
                                client_company_id: client_company.id,
                                payment_method_id: payment_method1.id)

pix_account1 = PixAccount.create!(pix_code: 11111111111111111123, 
                                client_company_id: client_company1.id,
                                payment_method_id: payment_method1.id)

boleto_account = BoletoAccount.create!(bank_code: 418, 
                          agency_code: 11122, 
                          account_number: 123654, 
                          client_company_id: client_company.id,
                          payment_method_id: payment_boleto.id)
boleto_account1 = BoletoAccount.create!(bank_code: 418, 
                          agency_code: 1122, 
                          account_number: 124, 
                          client_company_id: client_company.id,
                          payment_method_id: payment_boleto1.id)
boleto_account2 = BoletoAccount.create!(bank_code: 419, 
                          agency_code: 1122, 
                          account_number: 124, 
                          client_company_id: client_company1.id,
                          payment_method_id: payment_boleto.id)

card_account = CardAccount.create!(contract_number: 123654, 
                                  client_company_id: client_company.id,
                                  payment_method_id: payment_card.id)
card_account1 = CardAccount.create!(contract_number: 123674, 
                                  client_company_id: client_company.id,
                                  payment_method_id: payment_card1.id)
card_account2 = CardAccount.create!(contract_number: 123854, 
                                  client_company_id: client_company1.id,
                                  payment_method_id: payment_card1.id)


client_external = ClientExternal.create!(name: 'Teste', cpf: 11111111111)
client_external.client_external_token = 'aaaaaaaaaaaaaaaaaaaa'
client_external.save!
client_external1 = ClientExternal.create!(name: 'Teste', cpf: 11111111112)

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
order.order_token = 'aaaaaaaaaaaaaaaaaaaa'
order.save!

order1 = Order.create!(payment_type: :boleto,
                      payment_id: boleto_account.id,
                      client_company_id: client_company.id,
                      company_token: client_company.token,
                      client_product_id: product.id,
                      product_token: product.product_token,
                      client_external_id: client_external.id,
                      client_token: client_external.client_external_token,
                      boleto_address: 'Endereço teste',
                      price: product.price,
                      price_discounted: 20,
                      due_date: 5.days.from_now
                      )

order2 = Order.create!(payment_type: :cartao,
                      payment_id: pix_account.id,
                      client_company_id: client_company.id,
                      company_token: client_company.token,
                      client_product_id: product.id,
                      product_token: product.product_token,
                      client_external_id: client_external.id,
                      client_token: client_external.client_external_token,
                      card_number: 123654789,
                      print_name: 'Murilo Ramos',
                      card_cvv: 546,
                      price: product.price,
                      price_discounted: 19,
                      due_date: 5.days.from_now
                      )

receipt = Receipt.create!(payment_date: 1.day.from_now, auth_code: 418, order_id: order.id)

refused_history = RefusedHistory.create!(returned_code: :no_reason, attempt: 1.day.ago, order_id: order.id)
puts "Finished"
puts '       _    '
puts '      | |   '
puts '  ___ | | __'
puts ' / _ \| |/ /'
puts '| (_) |   <' 
puts ' \___/|_|\_]'