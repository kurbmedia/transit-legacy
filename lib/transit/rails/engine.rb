require 'rails'
require 'transit'

module Transit
  class Engine < Rails::Engine
    isolate_namespace Transit 
    
    ##
    # After initialization, dynamically create controllers for models 
    # that have been defined in application routes.
    # 
    ActiveSupport.on_load(:after_initialize) do
      TransitController.send(:include, Transit::Controller::Routing)
    end
        
    ActiveSupport.on_load(:action_controller) do
      helper Transit::Engine.helpers      
    end
      
  end
end