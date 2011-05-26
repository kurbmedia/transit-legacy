require 'rails'
require 'transit'

module Transit
  class Engine < Rails::Engine
    isolate_namespace Transit
    
    ActiveSupport.on_load(:after_initialize) do
      Transit::CONTROLLERS.dup.uniq.each do |klass|
        klass = "#{klass.classify.pluralize}Controller"
        unless Transit.const_defined?(klass)
          Transit.const_set(klass, Class.new(Transit::PackagesController))
        end
      end
    end
        
    ActiveSupport.on_load(:action_controller) do
      helper Transit::Engine.helpers
    end
      
  end
end