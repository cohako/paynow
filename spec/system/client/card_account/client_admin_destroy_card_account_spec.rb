require 'rails_helper'

describe 'Client destroy card account' do
  it 'successfully' do
    client_company = ClientCompany.create!(cnpj: '11111111111111', 
                          name: 'Empresa teste', 
                          billing_address: 'Endereço teste',
                          billing_email: 'email@email.com', 
                          admin: 'teste@teste.com',
                          domain: 'teste.com')
    user = User.create!(email: 'teste@teste.com', 
                        password: '123456', 
                        roles: :admin, 
                        client_company_id: client_company.id)
    payment_method = PaymentMethod.create!(name: 'Cartão Vermelho', 
                                          payment_type: :cartão, 
                                          payment_fee: '2.4', 
                                          max_monetary_fee: '50.54')
    CardAccount.create!(contract_number: 123123418, 
                        client_company_id: client_company.id,
                        payment_method_id: payment_method.id)

    login_as user, scope: :user
    visit user_root_path
    click_on 'Dados de Cartão'
    within "div#card_account" do
      click_on 'Apagar'
    end

    expect(page).to have_content('Apagado com sucesso')
    expect(page).to_not have_content(123123418)
  end

  it 'and destroy on show' do
    client_company = ClientCompany.create!(cnpj: '11111111111111', 
                          name: 'Empresa teste', 
                          billing_address: 'Endereço teste',
                          billing_email: 'email@email.com', 
                          admin: 'teste@teste.com',
                          domain: 'teste.com')
    user = User.create!(email: 'teste@teste.com', 
                        password: '123456', 
                        roles: :admin, 
                        client_company_id: client_company.id)
    payment_method = PaymentMethod.create!(name: 'Cartão Vermelho', 
                                          payment_type: :cartão, 
                                          payment_fee: '2.4', 
                                          max_monetary_fee: '50.54')
    card_account = CardAccount.create!(contract_number: 418123123, 
                                      client_company_id: client_company.id,
                                      payment_method_id: payment_method.id)

    login_as user, scope: :user
    
    visit user_client_company_card_account_path(card_account.id, card_account.client_company_id)
    click_on 'Apagar'

    expect(page).to have_content('Apagado com sucesso')
    expect(current_path).to eq (user_client_company_card_accounts_path(card_account))
  end

  it 'adn must be admin' do
    client_company = ClientCompany.create!(cnpj: '11111111111111', 
                          name: 'Empresa teste', 
                          billing_address: 'Endereço teste',
                          billing_email: 'email@email.com', 
                          admin: 'teste@teste.com',
                          domain: 'teste.com')
    user = User.create!(email: 'teste@teste.com', password: '123456',client_company_id: client_company.id)
    payment_method = PaymentMethod.create!(name: 'Cartão Vermelho', 
                                          payment_type: :cartão, 
                                          payment_fee: '2.4', 
                                          max_monetary_fee: '50.54')
    card_account = CardAccount.create!(contract_number: 41234123,  
                          client_company_id: client_company.id,
                          payment_method_id: payment_method.id)

    login_as user, scope: :user
    
    visit user_client_company_card_account_path(card_account.id, card_account.client_company_id)

    expect(page).to_not have_content('Apagar')
  end
end