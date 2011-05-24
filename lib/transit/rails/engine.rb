require 'rails'
module Transit
  class Engine < Rails::Engine
    
    ActiveSupport.on_load(:ActionController) do
      extend Transit::Delivery::ControllerHooks
    end
    
  end
end