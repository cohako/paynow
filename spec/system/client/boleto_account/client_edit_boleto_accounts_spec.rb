require 'rails_helper'

describe 'Clients edits boleto accounts' do
  it 'successfully' do
    client_company = ClientCompany.create!(cnpj: '11111111111111', 
                          name: 'Empresa teste', 
                          billing_address: 'Endereço teste',
                          billing_email: 'email@email.com', 
                         
                          domain: 'teste.com')
    user = User.create!(email: 'teste@teste.com', password: '123456', client_company_id: client_company.id)
    payment_method = PaymentMethod.create!(name: 'Boleto Vermelho', 
                                          payment_type: :boleto, 
                                          payment_fee: '2.4', 
                                          max_monetary_fee: '50.54')
    BoletoAccount.create!(bank_code: 418, 
                          agency_code: 11122, 
                          account_number: 123654, 
                          client_company_id: client_company.id,
                          payment_method_id: payment_method.id)

    login_as user, scope: :user
    visit user_root_path
    click_on 'Dados de Boleto'
    click_on 'Boleto Vermelho'
    click_on 'Editar'
    select '063<>Banco Bradescard S.A.', from: 'Código do banco'
    fill_in 'Código da agência', with: '111'
    fill_in 'Número da conta', with: '112233'
    select 'Boleto Vermelho', from: 'Emissor'
    click_on 'Atualizar Método de pagamento'

    expect(page).to have_content('63')
    expect(page).to have_content('111')
    expect(page).to have_content('112233')
    expect(page).to have_content('boleto')
    expect(page).to have_content('Boleto Vermelho')
    expect(page).to have_content('2,40%')
    expect(page).to have_content('R$ 50,54')
  end

  it 'and cannot be blank' do
    client_company = ClientCompany.create!(cnpj: '11111111111111', 
                          name: 'Empresa teste', 
                          billing_address: 'Endereço teste',
                          billing_email: 'email@email.com', 
                         
                          domain: 'teste.com')
    user = User.create!(email: 'teste@teste.com', password: '123456', client_company_id: client_company.id)
    payment_method = PaymentMethod.create!(name: 'Boleto Vermelho', 
                                          payment_type: :boleto, 
                                          payment_fee: '2.4', 
                                          max_monetary_fee: '50.54')
    BoletoAccount.create!(bank_code: 418, 
                          agency_code: 11122, 
                          account_number: 123654, 
                          client_company_id: client_company.id,
                          payment_method_id: payment_method.id)
    
    login_as user, scope: :user
    visit user_root_path
    click_on 'Dados de Boleto'
    click_on 'Boleto Vermelho'
    click_on 'Editar'
    select '', from: 'Código do banco'
    fill_in 'Código da agência', with: ''
    fill_in 'Número da conta', with: ''
    select '', from: 'Emissor'
    click_on 'Atualizar Método de pagamento'
    
    expect(page).to have_content('não pode ficar em branco', count: 4)
  end

  it 'and must be loged in' do
    visit user_root_path

    expect(current_path).to eq(new_user_session_path)
  end
end