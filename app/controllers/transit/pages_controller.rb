class Transit::PagesController < TransitController
  include Transit::Controller::Actions
  unloadable
  respond_to :html, :js
  
end