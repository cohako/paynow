class Admin::ClientCompaniesController < Admin::AdminController
  #before_action authenticate_admin!
  def index
  end
  def show
    @client_company = ClientCompany.find_by(token: params[:token])
  end
end