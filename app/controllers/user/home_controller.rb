class User::HomeController < User::UserController
  before_action :authenticate_user!
  
  layout 'user'

  def index
  end
end