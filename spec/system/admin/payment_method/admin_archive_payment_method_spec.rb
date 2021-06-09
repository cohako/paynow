require 'rails_helper'

describe 'Admin archive payment method' do
  it 'successfully' do
    admin = Admin.create!(email: 'teste@teste.com', password: 123456)
    PaymentMethod.create!(name: 'Boleto Vermelho', 
                          payment_type: :Boleto, 
                          payment_fee: '2,4', 
                          max_monetary_fee: '50,54')

    login_as admin, scope: :admin
    visit admin_root_path
    click_on 'Métodos de pagamento'
    click_on 'Boleto Vermelho'
    click_on 'Desativar método de pagamento'
    
    expect(page).to have_content('Desativado com sucesso')
    expect(page).to have_content('Desativado')
  end
  
end