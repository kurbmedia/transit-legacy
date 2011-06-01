class ApplicationController < ActionController::Base
  layout 'application'
  def ensure_authenticated!
    true    
  end
end