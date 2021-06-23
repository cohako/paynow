require 'rails_helper'

describe Order do
  context 'Validations' do
    it 'pix cannot be blank' do
      order = Order.new(payment_type: :pix)

      order.valid?

      expect(order.errors[:price]).to include('não pode ficar em branco')
      expect(order.errors[:price_discounted]).to include('não pode ficar em branco')
      expect(order.errors[:company_token]).to include('não pode ficar em branco')
      expect(order.errors[:product_token]).to include('não pode ficar em branco')
      expect(order.errors[:client_token]).to include('não pode ficar em branco')
      
    end

    it 'boleto cannot be blank' do
      order = Order.new(payment_type: :boleto)

      order.valid?

      expect(order.errors[:price]).to include('não pode ficar em branco')
      expect(order.errors[:price_discounted]).to include('não pode ficar em branco')
      expect(order.errors[:boleto_address]).to include('não pode ficar em branco')
      expect(order.errors[:company_token]).to include('não pode ficar em branco')
      expect(order.errors[:product_token]).to include('não pode ficar em branco')
      expect(order.errors[:client_token]).to include('não pode ficar em branco')
      
    end

    it 'card cannot be blank' do
      order = Order.new(payment_type: :cartao)

      order.valid?

      expect(order.errors[:price]).to include('não pode ficar em branco')
      expect(order.errors[:price_discounted]).to include('não pode ficar em branco')
      expect(order.errors[:card_number]).to include('não pode ficar em branco')
      expect(order.errors[:print_name]).to include('não pode ficar em branco')
      expect(order.errors[:card_cvv]).to include('não pode ficar em branco')
      expect(order.errors[:company_token]).to include('não pode ficar em branco')
      expect(order.errors[:product_token]).to include('não pode ficar em branco')
      expect(order.errors[:client_token]).to include('não pode ficar em branco')
      
    end

    it 'token must be uniq' do
      User.create!(email: 'user@teste.com', password: '123456')
      client_company = ClientCompany.create!(cnpj: '11111111111111', 
                            name: 'CodePlay ltda', 
                            billing_address: 'Endereço empresa',
                            billing_email: 'email@email.com', 
                            admin: '1',
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
      order1 = Order.create!(payment_type: :pix,
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
      order = Order.new(order_token: order1.order_token)

      order.valid?

      expect(order.errors[:order_token]).to include('já está em uso')

    end
  end
end

