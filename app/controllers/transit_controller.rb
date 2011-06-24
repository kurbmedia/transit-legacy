class TransitController < InheritedResources::Base  
  
  helper_method :edit_mode_enabled?
  respond_to :html, :js  
  before_filter :authenticate_admin!
  
  def edit_mode_enabled?
    true
  end
  
end