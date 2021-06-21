require 'rails_helper'

describe Receipt do
  context 'validations' do
    it 'cannot be blank' do
      receipt = Receipt.new

      receipt.valid?

      expect(receipt.errors[:payment_date]).to include('não pode ficar em branco')
      expect(receipt.errors[:auth_code]).to include('não pode ficar em branco')
    end
  end
end