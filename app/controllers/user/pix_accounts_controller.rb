require 'csv'
class User::PixAccountsController < User::UserController

  layout 'user'
  before_action :authenticate_user!
  before_action :admin?, only: %i[destroy]
  before_action :set_pix_account, only: %i[show edit update destroy admin?]
  before_action :set_pix_method, onlye: %i[new create edit update]
  before_action :set_company, only: %i[new create edit update admin?]
  before_action :set_banks, only: %i[new create edit update]

  def index
    @pix_accounts = PixAccount.where(client_company_id: current_user.client_company_id)
  end

  def show
  end
  
  def new
    @pix_account = PixAccount.new
  end

  def create
    @pix_account = @client_company.pix_accounts.new(pix_params)
    if @pix_account.save
      flash[:notice] = t('.success')
      redirect_to user_client_company_pix_account_path(@client_company.id, @pix_account.id)
    else
      render :new, notice: t('.fail')
    end
  end

  def update
    if @pix_account.update(pix_params)
      flash[:notice] = t('.success')
      redirect_to user_client_company_pix_account_path(@pix_account)
    else
      flash[:notice] = t('.fail')
      render :edit
    end
  end
  def destroy
    if @pix_account.destroy
      flash[:notice] = t('.success')
      redirect_to user_client_company_pix_accounts_path(@pix_account.client_company_id)
    end
  end
  private

  def pix_params
    params.require(:pix_account).permit(:pix_code,
                                          :payment_method_id, 
                                          :client_company_id)
  end
  
  def admin?
    @pix_account = PixAccount.find(params[:id])
    if current_user.admin?
    else
      flash[:notice] = t('.notadmin')
      redirect_to user_client_company_pix_account_path(@pix_account, @pix_account.client_company_id)
    end
  end

  def set_pix_account
    @pix_account = PixAccount.find(params[:id])
  end

  def set_pix_method
    @payment_pix = PaymentMethod.where(payment_type: :pix)
  end

  def set_company
    @client_company = ClientCompany.find(params[:client_company_token])
  end

  def set_banks
    @banks = CSV.parse(File.read(Rails.root.join('lib/assets/csv/bancos.csv')))
                  .map { |code, name| [code+'<>'+name, code] }
  end
end
