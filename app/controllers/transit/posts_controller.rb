class Transit::PostsController < ApplicationController

  include Transit::Controller::Actions
  unloadable
  respond_to :html, :js
  
end