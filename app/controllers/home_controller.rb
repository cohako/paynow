class HomeController < ApplicationController
  layout :verify_layout


  private

  def verify_layout
    return 'admin' if admin_signed_in?
    return 'user' if user_signed_in?

    'application'
  end
end