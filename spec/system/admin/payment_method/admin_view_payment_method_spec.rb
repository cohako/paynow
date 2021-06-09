require 'rails_helper'

describe 'Admin view payment method' do
  it 'successfully' do
    admin = Admin.create!(email: 'teste@teste.com', password: 123456)
    PaymentMethod.create!(name: 'Boleto Vermelho', 
                          payment_type: :Boleto, 
                          payment_fee: '2.40', 
                          max_monetary_fee: '70')
    PaymentMethod.create!(name: 'Cartão Laranja', 
                          payment_type: :Cartão, 
                          payment_fee: '12', 
                          max_monetary_fee: '50.54')
    PaymentMethod.create!(name: 'Pix Azul', 
                          payment_type: :Pix, 
                          payment_fee: '5,00', 
                          max_monetary_fee: '60,00')

    login_as admin, scope: :admin
    visit admin_root_path
    click_on 'Métodos de pagamento'

    expect(page).to have_content('Boleto Vermelho')
    expect(page).to have_content('Boleto')
    expect(page).to have_content('2,40%')
    expect(page).to have_content('R$ 70,00')
    expect(page).to have_content('Cartão Laranja')
    expect(page).to have_content('Cartão')
    expect(page).to have_content('12,00%')
    expect(page).to have_content('R$ 50,54')
    expect(page).to have_content('Pix Azul')
    expect(page).to have_content('Pix')
    expect(page).to have_content('5,00%')
    expect(page).to have_content('R$ 60,00')
  end
  it 'and none' do
    admin = Admin.create!(email: 'teste@teste.com', password: 123456)
    
    login_as admin, scope: :admin
    visit admin_root_path
    click_on 'Métodos de pagamento'

    expect(page).to have_content('Nenhum método de pagamento cadastrado')
  end
end