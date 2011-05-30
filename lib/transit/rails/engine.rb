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
      Transit.mappings.each do |mapping|
        mapping.build
        unless Transit.const_defined?(mapping.resource_controller)
          Transit.const_set(mapping.resource_controller, Class.new( Transit.const_get(mapping.controller_name) ))
        end
        
      end
    end
        
    ActiveSupport.on_load(:action_controller) do
      helper Transit::Engine.helpers
    end
    ActiveSupport.on_load(:action_view) do
      puts Transit::Engine.helpers.inspect
    end
      
  end
end