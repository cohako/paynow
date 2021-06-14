class User::ClientCompaniesController < User::UserController
  before_action :authenticate_user!
  before_action :set_client_company, only: %i[show edit update]
  before_action :admin?, only: %i[edit update]
  #before_action :company_created?, exclude: %i[new create]

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
    domain = current_user.email.split('@')
    @client_company.domain = domain[1]
    @client_company.admin = current_user.id
    if @client_company.save
      current_user.admin!
      current_user.client_company_id = @client_company.id
      current_user.save
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
                  :admin,
                  :domain)
  end

  def set_client_company
    @client_company = ClientCompany.find(params[:token])
  end

  def admin?
    @client_company = ClientCompany.find(params[:token])
    if current_user.admin?
    else
      flash[:notice] = t('.notadmin')
      redirect_to user_client_company_path(@client_company)
    end
  end
end