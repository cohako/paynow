class User::UserController < ActionController::Base
  before_action :authenticate_user!
  #before_action :company_created?, exclude: %i[new create]
  
  layout 'user'

  def company_created?
    redirect_to new_user_client_company_path if current_user.client_company_id.nil?
  end
end