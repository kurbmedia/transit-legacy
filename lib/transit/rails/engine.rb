require 'rails'
require 'transit'
require 'paperclip'
require 'motr'
require 'motr/orm/mongoid'

module Transit
  class Engine < Rails::Engine
    isolate_namespace Transit 
    
    ##
    # After initialization, dynamically create controllers for models 
    # that have been defined in application routes.
    # 
    initializer 'transit.generate_controllers', :after => :eager_load! do
      gen = Transit::Controller::Generator.new(:page, :post)
      gen.generate!
    end

    initializer 'transit.controller_hooks' do
      ActiveSupport.on_load(:after_initialize) do
        TransitController.send(:include, Transit::Controller::Routing)
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
    
    ActiveSupport.on_load(:action_controller) do
      helper Transit::Engine.helpers      
    end
      
  end
end