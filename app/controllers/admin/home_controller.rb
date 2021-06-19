class Admin::HomeController < ApplicationController
  before_action :authenticate_admin!
  
  def index
    @client_companies = ClientCompany.all
  end
end