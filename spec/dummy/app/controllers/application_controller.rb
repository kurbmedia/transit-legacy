class ApplicationController < ActionController::Base
  protect_from_forgery
  
  def authenticate_admin!
    true
  end
  
end
