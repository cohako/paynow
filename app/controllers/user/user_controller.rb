class User::UserController < ActionController::Base
  before_action :authenticate_user!
  layout 'user'
  
  private
  
  def company_must_exist
    redirect_back(fallback_location: user_root_path)
  end

  def check_company
    company_must_exist unless current_user.client_company_id.present?
  end

end