require 'rails'
require 'transit'
require 'paperclip'
require 'motr'
require 'motr/orm/mongoid'

module Transit
  class Engine < Rails::Engine
    
    isolate_namespace Transit
    
    config.paths['app/models'] << 'app/models/contexts'
    config.paths['app/models'] << 'app/models/transit'
    config.eager_load_paths << 'app/models/contexts'
    
    ##
    # After initialization, dynamically create controllers for models 
    # that have been defined in application routes.
    # 
    initializer 'transit.generate_controllers', :after => :eager_load! do
      gen = Transit::Controller::Generator.new(:page, :post)
      gen.generate!
      ActionController::Base.class_eval do
        helper Transit::Engine.helpers
        helper 'transit'
      end
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
      
  end
end