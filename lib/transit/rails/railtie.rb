require 'transit/rails/routing'

module Transit
  class Railtie < Rails::Railtie
    
    initializer 'transit.integration' do |app|
      app.config.responders.flash_keys = [ :success, :error ]
      app.config.assets.precompile << 'transit.css'
      app.config.assets.precompile << 'transit.js'
      app.config.action_view.default_form_builder = Transit::Builders::FormBuilder
      app.config.action_controller.responder = Transit::Controller::Responder
    end
    
    ActiveSupport.on_load(:action_controller) do
      self.responder = Transit::Controller::Responder
    end
    
    initializer 'transit.action_view' do
      ActionView::Base.default_form_builder = Transit::Builders::FormBuilder
      ActionView::Base.field_error_proc = lambda{ |html_tag, instance_tag| html_tag }
    end
    
    ActiveSupport.on_load(:action_view) do
      include TransitHelper
      include Transit::FormHelper
    end
    
  end
end