class User::ClientCompaniesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_client_company, only: %i[show edit update]

  def index
    @client_companies = ClientCompany.all
  end
  def show
  end
  
  def new
    @client_company = ClientCompany.new
  end

  def create
    @client_company = ClientCompany.new(clientcompany_params)
    @client_company.admin = current_user.email
    if @client_company.save
      current_user.admin!
      current_user.client_company_id = @client_company.id
      redirect_to user_client_company_path(@client_company)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @client_company.update(clientcompany_params)
      flash[:notice] = t('.success')
      render :show
    else
      flash[:notice] = t('.fail')
      render :edit
    end
  end

  private

  def clientcompany_params
    params.require(:client_company).permit(:cnpj, 
                  :name, 
                  :billing_address, 
                  :billing_email,
                  :admin)
  end

  def set_client_company
    @client_company = ClientCompany.find(params[:id])
  end

  def admin?
    current_user.admin?
  end
end