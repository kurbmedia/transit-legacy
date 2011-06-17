require 'kaminari'

class TransitController < ApplicationController
  include Transit::Controller::Helpers
  unloadable
  respond_to :html, :js
  
  before_filter :authenticate_for_transit!
end