require 'rails_helper'

require 'rails_helper'

describe ClientProduct do
  context 'Validations' do
    it 'cannot be blank' do
      product = ClientProduct.new

      product.valid?

      expect(product.errors[:name]).to include('não pode ficar em branco')
      expect(product.errors[:price]).to include('não pode ficar em branco')
      expect(product.errors[:boleto_discount]).to include('não pode ficar em branco')
      expect(product.errors[:card_discount]).to include('não pode ficar em branco')
      expect(product.errors[:pix_discount]).to include('não pode ficar em branco')
    end

    it 'and token must be uniq' do
      client_company = ClientCompany.create!(cnpj: '11111111111111', 
                                            name: 'Empresa teste', 
                                            billing_address: 'Endereço teste',
                                            billing_email: 'email@email.com', 
                                            admin: 'teste@teste.com',
                                            domain: 'teste.com')
      ClientProduct.create!(name: 'Curso de Café', 
                            price: '20.00', 
                            pix_discount: 5, 
                            card_discount: 5, 
                            boleto_discount: 2,
                            client_company_id: client_company.id,
                            product_token: '12345678911234567891')
      product = ClientProduct.new(product_token: 12345678911234567891)

      product.valid?

      expect(product.errors[:product_token]).to include('já está em uso')

    end
  end
end