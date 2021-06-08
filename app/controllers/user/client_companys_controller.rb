class User::ClientCompanysController < ApplicationController
  before_action :authenticate_user!
  before_action :set_client_company, only: %i[show edit update]

  def show
  end
  
  def new
    @client_company = ClientCompany.new
  end

  def create
    @client_company = ClientCompany.new(clientcompany_params)
    @client_company.admin = current_user.email
    if @client_company.save
      current_user.roles = 5
      current_user.client_company_id = @client_company.id
      redirect_to user_client_company_path(@client_company)
    else
      render :new
    end
  end

  private

  def clientcompany_params
    params.require(:client_company).permit(:cnpj, 
                  :name, 
                  :billing_address, 
                  :billing_email)
  end

  def set_client_company
    @client_company = ClientCompany.find(params[:id])
  end

end