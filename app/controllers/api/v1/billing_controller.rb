class BillingController < ApplicationController
  def create
  end

  def destroy
  end

  private
  def billing_params
    params.require(:billing).permit()
  end
end
