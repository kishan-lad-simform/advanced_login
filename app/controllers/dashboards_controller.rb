class DashboardsController < ApplicationController
  before_action :authenticate_admin!
  def index 
  end 
   
  def new
  end 
end