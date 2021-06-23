class Admin::PaymentMethodsController < Admin::AdminController
  
  before_action :set_payment_method, only: %i[show edit update desactive_method archive active_method unarchive]
  before_action :authenticate_admin!

  def index
    @payment_methods = PaymentMethod.all
  end

  def show
  end

  def new
    @payment_method = PaymentMethod.new
  end

  def create
    @payment_method = PaymentMethod.new(payment_method_params)
    if @payment_method.save
      redirect_to admin_payment_method_path(@payment_method)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @payment_method.update(payment_method_params)
      flash[:notice] = t('.success')
      render :show
    else
      flash[:notice] = t('.fail')
      render :edit
    end
  end

  def desactive_method
    if archive
      flash[:notice] = t('.success')
      render :show
    end
  end

  def active_method
    if unarchive
      flash[:notice] = t('.success')
      render :show
    end
  end

  private

  def unarchive
    @payment_method.status = 0
  end

  def archive
    @payment_method.status = 5
  end

  def set_payment_method
    @payment_method = PaymentMethod.find(params[:id])
  end

  def payment_method_params
    params.require(:payment_method).permit(:name, 
                   :payment_type, 
                   :payment_fee, 
                   :max_monetary_fee)
  end
end