class Api::V1::ClientExternalsController < Api::V1::ApiController

  def create
    
    @client_company = ClientCompany.find_by!(token: params[:client_company_token])
    @client_external = ClientExternal.find_by(cpf: external_params[:cpf])

    if @client_external
      @client_company.client_ext_companies.create!(client_external: @client_external)
    else
      @client_external = @client_company.client_externals.create!(external_params)
    end
    render json: {message: "Cliente criado com sucesso"}, status: :created
  end

  private

  def external_params
    params.require(:client_external).permit(:name, :cpf, :client_company_token)
  end
end