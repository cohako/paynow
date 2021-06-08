require 'rails_helper'

describe 'Validations' do
  it 'validates presence' do
    user = User.new

    user.valid?

    expect(user.errors[:email]).to include('não pode ficar em branco')
    expect(user.roles).to include('client_user')
  end
end
