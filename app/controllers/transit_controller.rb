class TransitController < ApplicationController   
  inherit_resources
  
  respond_to :html, :js  
  before_filter :authenticate_admin!
  
end