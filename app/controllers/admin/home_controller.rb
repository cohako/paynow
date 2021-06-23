class Admin::HomeController < Admin::AdminController
  before_action :authenticate_admin!

  layout 'admin'
  
  def index
    @client_companies = ClientCompany.all
  end
end