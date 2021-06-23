require 'rails_helper'

describe 'Client destroy boleto account' do
  it 'successfully' do
    client_company = ClientCompany.create!(cnpj: '11111111111111', 
                          name: 'Empresa teste', 
                          billing_address: 'Endereço teste',
                          billing_email: 'email@email.com', 
                         
                          domain: 'teste.com')
    user = User.create!(email: 'teste@teste.com', password: '123456', roles: :admin,client_company_id: client_company.id)
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
    within "div#boleto_account" do
      click_on 'Apagar'
    end

    expect(page).to have_content('Apagado com sucesso')
    expect(page).to_not have_content(11122)
    expect(page).to_not have_content(123654)
  end

  it 'and destroy on show' do
    client_company = ClientCompany.create!(cnpj: '11111111111111', 
                          name: 'Empresa teste', 
                          billing_address: 'Endereço teste',
                          billing_email: 'email@email.com', 
                         
                          domain: 'teste.com')
    user = User.create!(email: 'teste@teste.com', password: '123456', roles: :admin,client_company_id: client_company.id)
    payment_method = PaymentMethod.create!(name: 'Boleto Vermelho', 
                                          payment_type: :boleto, 
                                          payment_fee: '2.4', 
                                          max_monetary_fee: '50.54')
    boleto_account = BoletoAccount.create!(bank_code: 418, 
                          agency_code: 11122, 
                          account_number: 123654, 
                          client_company_id: client_company.id,
                          payment_method_id: payment_method.id)

    login_as user, scope: :user
    
    visit user_client_company_boleto_account_path(boleto_account.id, boleto_account.client_company_id)
    click_on 'Apagar'

    expect(page).to have_content('Apagado com sucesso')
    expect(current_path).to eq (user_client_company_boleto_accounts_path(boleto_account))
  end

  it 'adn must be admin' do
    client_company = ClientCompany.create!(cnpj: '11111111111111', 
                          name: 'Empresa teste', 
                          billing_address: 'Endereço teste',
                          billing_email: 'email@email.com', 
                         
                          domain: 'teste.com')
    user = User.create!(email: 'teste@teste.com', password: '123456',client_company_id: client_company.id)
    payment_method = PaymentMethod.create!(name: 'Boleto Vermelho', 
                                          payment_type: :boleto, 
                                          payment_fee: '2.4', 
                                          max_monetary_fee: '50.54')
    boleto_account = BoletoAccount.create!(bank_code: 418, 
                          agency_code: 11122, 
                          account_number: 123654, 
                          client_company_id: client_company.id,
                          payment_method_id: payment_method.id)

    login_as user, scope: :user
    
    visit user_client_company_boleto_account_path(boleto_account.id, boleto_account.client_company_id)

    expect(page).to_not have_content('Apagar')
  end
end