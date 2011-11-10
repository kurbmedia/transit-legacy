class TransitController < ApplicationController
  respond_to :html, :js  
  before_filter lambda{ send(Transit::Admin.authenticate_via) }
  
  def self.extended(klass)
    klass.class_eval do
      inherit_resources      
    end
    super
  end
  
  def edit_mode_enabled?
    true
  end
  
  def collection    
    end_of_association_chain.page((params[:page] || 1)).per(15)
  end
  
  def render(*args)
    options = args.extract_options!
    options[:layout] = false if request.xhr? and options[:layout].nil?
    args.push(options)
    super(*args)
  end
  
end