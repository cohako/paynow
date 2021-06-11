require 'rails_helper'

describe 'Admin register payment method' do
  it 'boleto successfully' do
    admin = Admin.create!(email: 'teste@teste.com', password: 123456)

    login_as admin, scope: :admin
    visit admin_root_path
    click_on 'Métodos de pagamento'
    click_on 'Cadastrar método de pagamento'
    fill_in 'Nome', with: 'Banco Bradesco'
    attach_file 'Ícone', Rails.root.join('spec/fixture/boleto.png')
    select 'boleto', from: 'Tipo de método'
    fill_in 'Taxa', with: '2.4'
    fill_in 'Valor máximo de taxa', with: '59.99'
    click_on 'Cadastrar Método de pagamento'

    expect(page).to have_content('Banco Bradesco')
    expect(page).to have_content('boleto')
    expect(page).to have_content('2,40%')
    expect(page).to have_content('R$ 59,99')
    expect(page).to have_link('Voltar', href: admin_payment_methods_path)
  end
  
  it 'credit card successfully' do
    admin = Admin.create!(email: 'teste@teste.com', password: 123456)

    login_as admin, scope: :admin
    visit admin_root_path
    click_on 'Métodos de pagamento'
    click_on 'Cadastrar método de pagamento'
    fill_in 'Nome', with: 'Banco Bradesco'
    attach_file 'Ícone', Rails.root.join('spec/fixture/boleto.png')
    select 'cartão', from: 'Tipo de método'
    fill_in 'Taxa', with: '2.4'
    fill_in 'Valor máximo de taxa', with: '59.99'
    click_on 'Cadastrar Método de pagamento'

    expect(page).to have_content('Banco Bradesco')
    expect(page).to have_content('cartão')
    expect(page).to have_content('2,40%')
    expect(page).to have_content('R$ 59,99')
    expect(page).to have_link('Voltar', href: admin_payment_methods_path)
  end

  it 'pix successfully' do
    admin = Admin.create!(email: 'teste@teste.com', password: 123456)

    login_as admin, scope: :admin
    visit admin_root_path
    click_on 'Métodos de pagamento'
    click_on 'Cadastrar método de pagamento'
    fill_in 'Nome', with: 'Banco Bradesco'
    attach_file 'Ícone', Rails.root.join('spec/fixture/boleto.png')
    select 'pix', from: 'Tipo de método'
    fill_in 'Taxa', with: '2.4'
    fill_in 'Valor máximo de taxa', with: '59.99'
    click_on 'Cadastrar Método de pagamento'

    expect(page).to have_content('Banco Bradesco')
    expect(page).to have_content('pix')
    expect(page).to have_content('2,40%')
    expect(page).to have_content('R$ 59,99')
    expect(page).to have_link('Voltar', href: admin_payment_methods_path)
  end
  
  it 'all fields must be filled' do
    admin = Admin.create!(email: 'teste@teste.com', password: 123456)

    login_as admin, scope: :admin
    visit admin_root_path
    click_on 'Métodos de pagamento'
    click_on 'Cadastrar método de pagamento'
    click_on 'Cadastrar Método de pagamento'

    expect(page).to have_content('não pode ficar em branco', count: 3)
  end

end