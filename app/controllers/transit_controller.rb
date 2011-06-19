require 'kaminari'
require 'inherited_resources'
class TransitController < ApplicationController 
  unloadable  
  inherit_resources
  respond_to :html, :js  
  before_filter :authenticate_admin!
  
end