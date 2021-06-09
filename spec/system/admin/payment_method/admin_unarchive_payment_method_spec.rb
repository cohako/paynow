require 'rails_helper'

describe 'Admin unarchive payment method' do
  it 'successfully' do
    admin = Admin.create!(email: 'teste@teste.com', password: 123456)
    payment_method = PaymentMethod.create!(name: 'Boleto Vermelho', 
                          payment_type: :Boleto, 
                          payment_fee: '2,4', 
                          status: :Desativado, 
                          max_monetary_fee: '50,54')
    
    login_as admin, scope: :admin
    visit admin_payment_method_path(payment_method)
    click_on 'Ativar método de pagamento'

    expect(page).to have_content('Ativado')
  end
end