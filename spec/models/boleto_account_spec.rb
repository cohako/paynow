require 'rails_helper'

describe BoletoAccount do
  context 'Validations' do
    
    it 'cannot be blank' do
      boleto_account = BoletoAccount.new
      
      boleto_account.valid?
      
      expect(boleto_account.errors[:bank_code]).to include('não pode ficar em branco')
      expect(boleto_account.errors[:agency_code]).to include('não pode ficar em branco')
      expect(boleto_account.errors[:account_number]).to include('não pode ficar em branco')

    end
  end
end
