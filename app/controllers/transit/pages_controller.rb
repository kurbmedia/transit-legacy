class Transit::PagesController < ApplicationController

  include Transit::Controller::Actions
  unloadable
  respond_to :html, :js
  
end