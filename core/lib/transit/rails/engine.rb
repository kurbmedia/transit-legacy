require 'rails'

module Transit
  class Engine < Rails::Engine

    isolate_namespace Transit
    config.transit = Transit::Config
    
    initializer 'transit.customizations' do |app|
    end    
    initializer 'transit.contexts', :before => :eager_load! do |app|
      app.config.paths['app/models']  << 'app/models/contexts'
    end        
    
    ##
    # After initialization, dynamically create controllers for models 
    # that have been defined in application routes.
    # 
    initializer 'transit.generate_controllers', :after => :eager_load! do
      gen = Transit::Controller::Generator.new(:page, :post)
      gen.generate!     
    end
          
  end
end

require 'transit/support/paperclip'