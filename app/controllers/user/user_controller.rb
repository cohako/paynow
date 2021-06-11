class User::UserController < ActionController::Base
  layout 'user'
  before_action :authenticate_user!
end