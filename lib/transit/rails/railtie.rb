require 'transit/rails/routing'

module Transit
  class Railtie < Rails::Railtie
    
    initializer 'transit.integration' do |app|
      app.config.responders.flash_keys  = [ :success, :error ]
      ActionView::Base.field_error_proc = lambda{ |html_tag, instance_tag| html_tag }
    end
    
    ActiveSupport.on_load(:action_controller) do
      self.responder = Transit::Controller::Responder
    end
    
  end
end