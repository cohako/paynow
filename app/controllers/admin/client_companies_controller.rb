class Admin::ClientCompaniesController < Admin::AdminController
  before_action :set_company, only: %i[show]
  def index
  end
  def show
  end

  private

  def set_company
    @client_company = ClientCompany.find_by(token: params[:token])
  end
end