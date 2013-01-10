class ApplicationController < ActionController::Base
  protect_from_forgery
  
  def authenticate_admin!
  end
end
