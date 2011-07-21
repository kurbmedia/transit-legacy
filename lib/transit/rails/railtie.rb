require 'transit/rails/routing'

module Transit
  class Railtie < Rails::Railtie
    
    initializer 'transit.integration' do |app|
      app.config.responders.flash_keys = [ :success, :error ]
      app.config.action_controller.responder = Transit::Controller::Responder      
      if defined?(SimpleForm)
        require 'transit/rails/integration/simple_form'        
      end
      ActionView::Base.field_error_proc = lambda{ |html_tag, instance_tag| html_tag }
    end
    
    ActiveSupport.on_load(:action_controller) do
      self.responder = Transit::Controller::Responder
      InheritedResources.flash_keys = [ :success, :error ]
    end
    
  end
end