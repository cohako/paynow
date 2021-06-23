require 'rails_helper'

describe 'Client register pix account' do
  it 'successfully' do

    client_company = ClientCompany.create!(cnpj: '11111111111111', 
                                          name: 'Empresa teste', 
                                          billing_address: 'Endereço teste',
                                          billing_email: 'email@email.com', 
                                         
                                          domain: 'teste.com')
    user = User.create!(email: 'teste@teste.com', password: '123456', client_company_id: client_company.id)
    payment_method = PaymentMethod.create!(name: 'Pix Vermelho', 
                                          payment_type: :pix, 
                                          payment_fee: '2.4', 
                                          max_monetary_fee: '50.54')

    login_as user, scope: :user
    visit user_root_path
    click_on 'Dados de Pix'
    click_on 'Cadastrar dados de Pix'
    fill_in 'Código de Pix', with: '11234567891123456789'
    select 'Pix Vermelho', from: 'Emissor'
    click_on 'Cadastrar Método de pagamento'

    expect(page).to have_content('11234567891123456789')
    expect(page).to have_content('pix')
    expect(page).to have_content('Pix Vermelho')
    expect(page).to have_content('2,40%')
    expect(page).to have_content('R$ 50,54')
  end

  it 'and cannot be blank' do
    client_company = ClientCompany.create!(cnpj: '11111111111111', 
                                          name: 'Empresa teste', 
                                          billing_address: 'Endereço teste',
                                          billing_email: 'email@email.com', 
                                         
                                          domain: 'teste.com')
     user = User.create!(email: 'teste@teste.com', 
                        password: '123456', 
                        client_company_id: client_company.id)
     payment_method = PaymentMethod.create!(name: 'Pix Vermelho', 
                                            payment_type: :pix, 
                                            payment_fee: '2.4', 
                                            max_monetary_fee: '50.54')
    
    login_as user, scope: :user
    visit user_root_path
    click_on 'Dados de Pix'
    click_on 'Cadastrar dados de Pix' 
    click_on 'Cadastrar Método de pagamento'
    
    expect(page).to have_content('não pode ficar em branco', count: 1)
  end
  
  it 'and must be loged in' do
    visit user_root_path

    expect(current_path).to eq(new_user_session_path)
  end
end