require 'rails_helper'

describe 'Admin edits payment method' do
  it 'successfully' do
    
    admin = Admin.create!(email: 'admin@paynow.com', password: 123456)
    PaymentMethod.create!(name: 'Boleto Vermelho', 
                          payment_type: :boleto, 
                          payment_fee: '2,4', 
                          max_monetary_fee: '50,54')

    login_as admin, scope: :admin
    visit admin_root_path
    click_on 'Métodos de pagamento'
    click_on 'Boleto Vermelho'
    click_on 'Editar'
    fill_in 'Nome', with: 'Boleto Laranja'
    select 'boleto', from: 'Tipo de método'
    fill_in 'Taxa', with: '2.5'
    fill_in 'Valor máximo de taxa', with: '59.99'
    click_on 'Atualizar Método de pagamento'
    
    expect(page).to have_content('Atualizado com sucesso')
    expect(page).to have_content('Boleto Laranja')
    expect(page).to have_content('Boleto')
    expect(page).to have_content('2,50%')
    expect(page).to have_content('R$ 59,99')
  end

  it 'all fields must be filled' do
    admin = Admin.create!(email: 'admin@paynow.com', password: 123456)
    PaymentMethod.create!(name: 'Boleto Vermelho', 
                          payment_type: :boleto, 
                          payment_fee: '2,4', 
                          max_monetary_fee: '50,54')

    login_as admin, scope: :admin
    visit admin_root_path
    click_on 'Métodos de pagamento'
    click_on 'Boleto Vermelho'
    click_on 'Editar'
    fill_in 'Nome', with: ''
    select 'boleto', from: 'Tipo de método'
    fill_in 'Taxa', with: ''
    fill_in 'Valor máximo de taxa', with: ''
    click_on 'Atualizar Método de pagamento'
    
    expect(page).to have_content('Não foi possível atualizar')
    expect(page).to have_content('não pode ficar em branco', count: 3)
  end
end