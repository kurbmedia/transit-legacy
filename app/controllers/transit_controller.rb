class TransitController < ApplicationController
  include Transit::Controller::Helpers
  unloadable
  respond_to :html, :js
end