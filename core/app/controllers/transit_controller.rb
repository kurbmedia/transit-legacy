class TransitController < ApplicationController
  inherit_resources
  
  helper_method :edit_mode_enabled?
  respond_to :html, :js  
  before_filter :authenticate_admin!
  
  def edit_mode_enabled?
    true
  end
  
  def render(*args)
    args.first[:layout] = false if request.xhr? and args.first[:layout].nil?
    super
  end
  
end