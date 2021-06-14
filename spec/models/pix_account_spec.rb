require 'rails_helper'

require 'rails_helper'

describe PixAccount do
  context 'Validations' do
    
    it 'cannot be blank' do
      pix_account = PixAccount.new
      
      pix_account.valid?
      
      expect(pix_account.errors[:pix_code]).to include('não pode ficar em branco')
    end

    it 'must be uniq' do
      client_company = ClientCompany.create!(cnpj: '123412341234', 
                            name: 'empresa', 
                            billing_address: 'endereço', 
                            billing_email: 'email@email.com', 
                            token: '123abc',
                            domain: 'teste.com')
      payment_method = PaymentMethod.create!(name: 'Boleto Vermelho', 
                                            payment_type: :boleto, 
                                            payment_fee: '2,4', 
                                            max_monetary_fee: '50,54')
      PixAccount.create!(pix_code: 41234123,  
                          client_company_id: client_company.id,
                          payment_method_id: payment_method.id)

      pix_account = PixAccount.new(pix_code: 41234123)

      pix_account.valid?

      expect(pix_account.errors[:pix_code]).to include('já está em uso')
    end

    it 'must have maximun length equal a 20' do
      client_company = ClientCompany.create!(cnpj: '123412341234', 
                            name: 'empresa', 
                            billing_address: 'endereço', 
                            billing_email: 'email@email.com', 
                            token: '123abc',
                            domain: 'teste.com')
      payment_method = PaymentMethod.create!(name: 'Boleto Vermelho', 
                                            payment_type: :pix, 
                                            payment_fee: '2,4', 
                                            max_monetary_fee: '50,54')
      pix_account = PixAccount.new(pix_code: 111111111111111111111)

      pix_account.valid?

      expect(pix_account.errors[:pix_code]).to include("é muito longo (máximo: 20 caracteres)")
    end
  end
end
