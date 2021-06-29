class HomeController < ApplicationController
  layout :verify_layout

  def index
    @receipt = Receipt.new
  end


  private

  def verify_layout
    return 'user' if user_signed_in?
    return 'admin' if admin_signed_in?

    'application'
  end
end