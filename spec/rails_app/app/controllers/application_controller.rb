class ApplicationController < ActionController::Base
  protect_from_forgery
  
  def authenticate_for_transit!
    true
  end
  
end
