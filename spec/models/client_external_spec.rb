require 'rails_helper'

describe ClientExternal do
  context 'Validations' do
    it 'cannot be blank' do
      client_external = ClientExternal.new

      client_external.valid?

      expect(client_external.errors[:name]).to include('não pode ficar em branco')
      expect(client_external.errors[:cpf]).to include('não pode ficar em branco')
    end
    
    it 'must create a token' do
      client_external = ClientExternal.create!(name: 'Murilo', cpf: 12345678911)

      expect(client_external.client_external_token).to_not eq(nil)
    end

    it 'and token and cpf must be uniq' do
      client_external = ClientExternal.create!(name: 'Murilo', cpf: 12345678911)

      client_external1 = ClientExternal.new(cpf: 12345678911, client_external_token: client_external.client_external_token )

      client_external1.valid?

      expect(client_external1.errors[:client_external_token]).to include('já está em uso')
      expect(client_external1.errors[:cpf]).to include('já está em uso')
    end

    it 'and cpf must have 11 chars' do
      client_external = ClientExternal.new(cpf: 123)
      client_external1 = ClientExternal.new(cpf: 12132132131313131)

      client_external.valid?
      client_external1.valid?

      expect(client_external.errors[:cpf]).to include('não possui o tamanho esperado (11 caracteres)')
      expect(client_external1.errors[:cpf]).to include('não possui o tamanho esperado (11 caracteres)')
    end
  end
end