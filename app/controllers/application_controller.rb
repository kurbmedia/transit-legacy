class ApplicationController < ActionController::Base
  def ensure_authenticated!
    true    
  end
end