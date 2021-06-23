class User::ClientCompaniesController < User::UserController
  before_action :authenticate_user!
  before_action :set_client_company, only: %i[show edit update regenerate_token]
  before_action :admin?, only: %i[edit update regenerate_token]
  before_action :check_company, only: %i[show index edit update regenerate_token]

  def index
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
      redirect_to user_client_company_path(@client_company.token)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @client_company.update(clientcompany_params)
      flash[:notice] = t('.success')
      redirect_to user_client_company_path(@client_company.token)
    else
      flash[:notice] = t('.fail')
      render :edit
    end
  end

  def regenerate_token
    token =  SecureRandom.base58(20)
    colision = ClientCompany.where(token: :token)
    if colision.empty?
      @client_company.token = token
      @client_company.save
      redirect_to user_client_company_path(@client_company.token)
    else
      self.generate_token
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
    @client_company = ClientCompany.find_by(token: params[:token])
  end

  def admin?
    @client_company = ClientCompany.find_by(token: params[:token])
    unless current_user.admin?
      flash[:notice] = t('.notadmin')
      redirect_to user_client_company_path(@client_company.token)
    end
  end
end