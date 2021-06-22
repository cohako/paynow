require 'rails_helper'

describe RefusedHistory do
  context 'Validations' do
    it 'can not be blank' do
      refusedhistory = RefusedHistory.new

      refusedhistory.valid?

      expect(refusedhistory.errors[:attempt]).to include('não pode ficar em branco')
    end
  end
end