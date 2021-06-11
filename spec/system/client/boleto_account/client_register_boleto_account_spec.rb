require 'rails_helper'

describe 'Client registe boleto account' do
  it 'successfully' do

    client_company = ClientCompany.create!(cnpj: '11111111111111', 
    name: 'Empresa teste', 
    billing_address: 'Endereço teste',
    billing_email: 'email@email.com', 
    admin: 'teste@teste.com')
    user = User.create!(email: 'teste@teste.com', password: '123456', client_company_id: client_company.id)
    payment_method = PaymentMethod.create!(name: 'Boleto Vermelho', 
                                          payment_type: :boleto, 
                                          payment_fee: '2.4', 
                                          max_monetary_fee: '50.54')

    login_as user, scope: :user
    visit user_root_path
    click_on 'Dados de Pagamento'
    click_on 'Cadastrar dados de Boleto' #dentro de payment_method#index botão cadastrar boleto
    fill_in 'Código do banco', with: '1234'
    fill_in 'Código da agência', with: '111'
    fill_in 'Número da conta', with: '112233'
    click_on 'Cadastrar Método de pagamento'

    expect(page).to have_content('1234')
    expect(page).to have_content('111')
    expect(page).to have_content('112233')
    expect(page).to have_content('boleto')
    expect(page).to have_content('Boleto Vermelho')
    expect(page).to have_content('2,40%')
    expect(page).to have_content('R$ 50,54')
  end
end