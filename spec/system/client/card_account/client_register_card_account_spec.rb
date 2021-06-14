require 'rails_helper'

describe 'Client register card account' do
  it 'successfully' do

    client_company = ClientCompany.create!(cnpj: '11111111111111', 
                          name: 'Empresa teste', 
                          billing_address: 'Endereço teste',
                          billing_email: 'email@email.com', 
                          admin: 'teste@teste.com',
                          domain: 'teste.com')
    user = User.create!(email: 'teste@teste.com', 
                        password: '123456', 
                        client_company_id: client_company.id)
    payment_method = PaymentMethod.create!(name: 'Cartão Azul', 
                                          payment_type: :cartão, 
                                          payment_fee: '2.4', 
                                          max_monetary_fee: '50.54')

    login_as user, scope: :user
    visit user_root_path
    click_on 'Dados de Cartão'
    click_on 'Cadastrar dados de Cartão'
    fill_in 'Código de contrato', with: '111111111'
    select 'Cartão Azul', from: 'Emissor'
    click_on 'Cadastrar Método de pagamento'

    expect(page).to have_content('111111111')
    expect(page).to have_content('cartão')
    expect(page).to have_content('Cartão Azul')
    expect(page).to have_content('2,40%')
    expect(page).to have_content('R$ 50,54')
  end

  it 'and cannot be blank' do
    client_company = ClientCompany.create!(cnpj: '11111111111111', 
                          name: 'Empresa teste', 
                          billing_address: 'Endereço teste',
                          billing_email: 'email@email.com', 
                          admin: 'teste@teste.com',
                          domain: 'teste.com')
     user = User.create!(email: 'teste@teste.com', 
                        password: '123456', 
                        client_company_id: client_company.id)
     payment_method = PaymentMethod.create!(name: 'Cartão Azul', 
                                            payment_type: :cartão, 
                                            payment_fee: '2.4', 
                                            max_monetary_fee: '50.54')
    
    login_as user, scope: :user
    visit user_root_path
    click_on 'Dados de Cartão'
    click_on 'Cadastrar dados de Cartão' 
    click_on 'Cadastrar Método de pagamento'
    
    expect(page).to have_content('não pode ficar em branco', count: 1)
  end
  
  it 'and must be loged in' do
    visit user_root_path

    expect(current_path).to eq(new_user_session_path)
  end
end