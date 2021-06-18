class User::UserController < ActionController::Base
  before_action :authenticate_user!
  layout 'user'
  
  private
  
  def back_to_root
    redirect_back(fallback_location: user_root_path)
  end

  def check_company
    back_to_root unless current_user.client_company_id.present?
  end

end