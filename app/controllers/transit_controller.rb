class TransitController < InheritedResources::Base  
  respond_to :html, :js  
  before_filter :authenticate_admin!
  
end