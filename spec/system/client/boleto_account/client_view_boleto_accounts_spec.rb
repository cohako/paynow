require 'rails_helper'

describe 'Client view boleto account' do
  it 'successfully' do

    client_company = ClientCompany.create!(cnpj: '11111111111111', 
                          name: 'Empresa teste', 
                          billing_address: 'Endereço teste',
                          billing_email: 'email@email.com', 
                         
                          domain: 'teste.com')
    client_company2 = ClientCompany.create!(cnpj: '11111111111112', 
                          name: 'Empresa teste', 
                          billing_address: 'Endereço teste',
                          billing_email: 'email@email.com', 
                         
                          domain: 'teste2.com')

    user = User.create!(email: 'teste@teste.com', password: '123456', client_company_id: client_company.id)

    payment_method = PaymentMethod.create!(name: 'Boleto Vermelho', 
                                          payment_type: :boleto, 
                                          payment_fee: '2.4', 
                                          max_monetary_fee: '50.54')

    payment_method2 = PaymentMethod.create!(name: 'Boleto Azul', 
                                          payment_type: :boleto, 
                                          payment_fee: '2.5', 
                                          max_monetary_fee: '50.53')
                    
    

    BoletoAccount.create!(bank_code: 418, 
                          agency_code: 11122, 
                          account_number: 123654, 
                          client_company_id: client_company.id,
                          payment_method_id: payment_method.id)
    BoletoAccount.create!(bank_code: 418, 
                          agency_code: 1122, 
                          account_number: 124, 
                          client_company_id: client_company.id,
                          payment_method_id: payment_method2.id)
    BoletoAccount.create!(bank_code: 419, 
                          agency_code: 1122, 
                          account_number: 124, 
                          client_company_id: client_company2.id,
                          payment_method_id: payment_method2.id)
    
    login_as user, scope: :user
    visit user_root_path
    click_on 'Dados de Boleto'

    expect(page).to have_content('124')
    expect(page).to have_content('Boleto Vermelho')
    expect(page).to have_content('123654')
    expect(page).to have_content('Boleto Azul')
  end

  it 'and there is none' do
    client_company = ClientCompany.create!(cnpj: '11111111111111', 
                          name: 'Empresa teste', 
                          billing_address: 'Endereço teste',
                          billing_email: 'email@email.com', 
                         
                          domain: 'teste.com')
    user = User.create!(email: 'teste@teste.com', password: '123456', roles: :admin,client_company_id: client_company.id)
    login_as user, scope: :user
    visit user_root_path
    click_on 'Dados de Boleto'

    expect(page).to have_content('Nenhum dado de boleto cadastrado')
  end

  
  it 'and must be loged in' do
    client_company = ClientCompany.create!(cnpj: '11111111111111', 
                          name: 'Empresa teste', 
                          billing_address: 'Endereço teste',
                          billing_email: 'email@email.com', 
                         
                          domain: 'teste.com')
    visit user_client_company_boleto_accounts_path(client_company)

    expect(current_path).to eq(new_user_session_path)
  end
end