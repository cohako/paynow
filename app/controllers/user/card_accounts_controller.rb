require 'csv'
class User::CardAccountsController < User::UserController
  before_action :authenticate_user!
  before_action :admin?, only: %i[destroy]
  before_action :set_card_account, only: %i[show edit update destroy admin?]
  before_action :set_card_method, onlye: %i[new create edit update]
  before_action :set_company, only: %i[index new create edit update admin?]
  before_action :set_banks, only: %i[new create edit update]

  def index
    @card_accounts = CardAccount.where(client_company_id: current_user.client_company_id)
  end

  def show
  end
  
  def new
    @card_account = CardAccount.new
  end

  def create
    @card_account = @client_company.card_accounts.new(card_params)
    if @card_account.save
      flash[:notice] = t('.success')
      redirect_to user_client_company_card_account_path(@client_company.id, @card_account.id)
    else
      render :new, notice: t('.fail')
    end
  end

  def update
    if @card_account.update(card_params)
      flash[:notice] = t('.success')
      redirect_to user_client_company_card_account_path(@card_account)
    else
      flash[:notice] = t('.fail')
      render :edit
    end
  end

  def destroy
    if @card_account.destroy
      flash[:notice] = t('.success')
      redirect_to user_client_company_card_accounts_path(@card_account.client_company_id)
    end
  end
  
  private

  def card_params
    params.require(:card_account).permit(:contract_number, 
                                        :payment_method_id, 
                                        :client_company_id)
  end
  
  def admin?
    @card_account = CardAccount.find(params[:id])
    if current_user.admin?
    else
      flash[:notice] = t('.notadmin')
      redirect_to user_client_company_card_account_path(@card_account, @card_account.client_company_id)
    end
  end

  def set_card_account
    @card_account = CardAccount.find(params[:id])
  end

  def set_card_method
    @payment_card = PaymentMethod.where(payment_type: :cartão)
  end

  def set_company
    @client_company = ClientCompany.find(params[:client_company_token])
  end

  def set_banks
    @banks = CSV.parse(File.read(Rails.root.join('lib/assets/csv/bancos.csv')))
                  .map { |code, name| [code+'<>'+name, code] }
  end
end
