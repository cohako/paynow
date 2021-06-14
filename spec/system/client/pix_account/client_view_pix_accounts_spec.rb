require 'rails_helper'

describe 'Client view pix account' do
  it 'successfully' do

    client_company = ClientCompany.create!(cnpj: '11111111111111', 
                                          name: 'Empresa teste', 
                                          billing_address: 'Endereço teste',
                                          billing_email: 'email@email.com', 
                                          admin: 'teste@teste.com',
                                          domain: 'teste.com')

    client_company2 = ClientCompany.create!(cnpj: '11111111111112', 
                                          name: 'Empresa teste', 
                                          billing_address: 'Endereço teste',
                                          billing_email: 'email@email.com', 
                                          admin: 'teste@teste.com',
                                          domain: 'teste2.com')

    user = User.create!(email: 'teste@teste.com', password: '123456', client_company_id: client_company.id)

    payment_method = PaymentMethod.create!(name: 'Pix Vermelho', 
                                          payment_type: :pix, 
                                          payment_fee: '2.4', 
                                          max_monetary_fee: '50.54')

    payment_method2 = PaymentMethod.create!(name: 'Pix Azul', 
                                          payment_type: :pix, 
                                          payment_fee: '2.5', 
                                          max_monetary_fee: '50.53')
                    
    

    PixAccount.create!(pix_code: 11111111111111111112, 
                          client_company_id: client_company.id,
                          payment_method_id: payment_method.id)
    PixAccount.create!(pix_code: 11111111111111111119, 
                          client_company_id: client_company.id,
                          payment_method_id: payment_method2.id)
    PixAccount.create!(pix_code: 11111111111111111111,  
                          client_company_id: client_company2.id,
                          payment_method_id: payment_method2.id)
    
    login_as user, scope: :user
    visit user_root_path
    click_on 'Dados de Pix'

    expect(page).to have_content('11111111111111111119')
    expect(page).to have_content('Pix Vermelho')
    expect(page).to have_content('11111111111111111112')
    expect(page).to have_content('Pix Azul')
  end

  it 'and there is none' do
    client_company = ClientCompany.create!(cnpj: '11111111111111', 
                                          name: 'Empresa teste', 
                                          billing_address: 'Endereço teste',
                                          billing_email: 'email@email.com', 
                                          admin: 'teste@teste.com',
                                        domain: 'teste.com')
    user = User.create!(email: 'teste@teste.com', password: '123456', roles: :admin,client_company_id: client_company.id)
    login_as user, scope: :user
    visit user_root_path
    click_on 'Dados de Pix'

    expect(page).to have_content('Nenhum dado de pix cadastrado')
  end

  it 'and must be loged in' do
    client_company = ClientCompany.create!(cnpj: '11111111111111', 
                                          name: 'Empresa teste', 
                                          billing_address: 'Endereço teste',
                                          billing_email: 'email@email.com', 
                                          admin: 'teste@teste.com',
                                          domain: 'teste.com')
    visit user_client_company_pix_accounts_path(client_company)

    expect(current_path).to eq(new_user_session_path)
  end
end