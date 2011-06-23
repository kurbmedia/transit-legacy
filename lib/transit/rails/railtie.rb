require 'transit/rails/routing'

module Transit
  class Railtie < Rails::Railtie
    
    initializer 'transit.integration' do |app|
      app.config.responders.flash_keys = [ :success, :error ]
      app.config.assets.precompile << 'transit.css'
      app.config.assets.precompile << 'transit.js'
      app.config.action_view.default_form_builder = Transit::Builders::FormBuilder
    end
    
    ActiveSupport.on_load(:action_controller) do
      self.responder = Transit::Controller::Responder
    end
    
  end
end