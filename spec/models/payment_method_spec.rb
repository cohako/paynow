require 'rails_helper'

describe PaymentMethod do
  context 'Validations' do
    it 'cannot be blank' do
      payment_method = PaymentMethod.new

      payment_method.valid?

      expect(payment_method.errors[:name]).to include('não pode ficar em branco')
      expect(payment_method.errors[:payment_fee]).to include('não pode ficar em branco')
      expect(payment_method.errors[:max_monetary_fee]).to include('não pode ficar em branco')
    end
  end
end
