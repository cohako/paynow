require 'rails_helper'

describe 'Validations' do
  it 'cannot be blank' do
    client_company = ClientCompany.new

    client_company.valid?

    expect(client_company.errors[:cnpj]).to include('não pode ficar em branco')
    expect(client_company.errors[:name]).to include('não pode ficar em branco')
    expect(client_company.errors[:billing_address]).to include('não pode ficar em branco')
    expect(client_company.errors[:billing_email]).to include('não pode ficar em branco')
  end

  it 'must be uniq' do
    client_company = ClientCompany.create!(cnpj: '123412341234', 
                        name: 'empresa', 
                        billing_address: 'endereço', 
                        billing_email: 'email@email.com', 
                        domain: 'teste.com')
    client_company = ClientCompany.new(cnpj: '123412341234', 
                                      token: client_company.token)

    client_company.valid?

    expect(client_company.errors[:cnpj]).to include('já está em uso')
    expect(client_company.errors[:token]).to include('já está em uso')

  end
end