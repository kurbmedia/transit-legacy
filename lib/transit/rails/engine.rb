require 'rails'
require 'paperclip'

module Transit
  class Engine < Rails::Engine
    
    config.autoload_paths << File.expand_path("../../lib/transit", __FILE__)
    
    isolate_namespace Transit
    paths['app/models'] << 'app/models/contexts'
    paths['app/helpers'] << 'app/helpers'
    
    ##
    # After initialization, dynamically create controllers for models 
    # that have been defined in application routes.
    # 
    initializer 'transit.generate_controllers', :after => :eager_load! do
      gen = Transit::Controller::Generator.new(:page, :post)
      gen.generate!     
    end
 
    initializer 'transit.paperclip' do
      def Paperclip.logger
        Rails.logger 
      end      
      ::Paperclip.interpolates(:uid) do |attachment, style|
        "#{attachment.instance.uid}" 
      end
      ::Paperclip.interpolates(:normalize_name) do |attachment, style|
        "#{attachment.instance.normalize_name(attachment, style)}" 
      end
    end
    
    ActiveSupport.on_load(:action_view) do
      include TransitHelper
      field_error_proc = lambda{ |html_tag, instance_tag| html_tag }
    end    
          
  end
end

require 'transit/rails/railtie'
Sprockets::Engines
Sprockets.register_engine '.jst', Transit::Builders::Jst