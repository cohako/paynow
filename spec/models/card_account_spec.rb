require 'rails_helper'

describe CardAccount do
  context 'Validations' do
    
    it 'cannot be blank' do
      card_account = CardAccount.new
      
      card_account.valid?
      
      expect(card_account.errors[:contract_number]).to include('não pode ficar em branco')
    end

    it 'must be uniq' do
      client_company = ClientCompany.create!(cnpj: '123412341234', 
                            name: 'empresa', 
                            billing_address: 'endereço', 
                            billing_email: 'email@email.com',
                            domain: 'teste.com')
      payment_method = PaymentMethod.create!(name: 'Boleto Vermelho', 
                                            payment_type: :cartao, 
                                            payment_fee: '2,4', 
                                            max_monetary_fee: '50,54')
      CardAccount.create!(contract_number: 41234123,  
                          client_company_id: client_company.id,
                          payment_method_id: payment_method.id)

      card_account = CardAccount.new(contract_number: 41234123)

      card_account.valid?

      expect(card_account.errors[:contract_number]).to include('já está em uso')
    end

    it 'must have maximun length equal a 20' do
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
      card_account = CardAccount.new(contract_number: 111111111111111111111)

      card_account.valid?

      expect(card_account.errors[:contract_number]).to include("é muito longo (máximo: 20 caracteres)")
    end
  end
end
