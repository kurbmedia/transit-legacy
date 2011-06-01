require 'rails'
require 'transit'
require 'paperclip'

module Transit
  class Engine < Rails::Engine
    isolate_namespace Transit 
    
    ##
    # After initialization, dynamically create controllers for models 
    # that have been defined in application routes.
    # 
    ActiveSupport.on_load(:after_initialize) do
      TransitController.send(:include, Transit::Controller::Routing)
            
      Transit::Post.subclasses.each do |sub|
        controller_name = "#{sub.to_s.pluralize}Controller"
        unless Transit.const_defined?(controller_name)
          Transit.const_set(controller_name, Class.new( Transit::PostsController) )
        end
      end
      
      Transit::Page.subclasses.each do |sub|
        controller_name = "#{sub.to_s.pluralize}Controller"
        unless Transit.const_defined?(controller_name)
          Transit.const_set(controller_name, Class.new( Transit::PagesController) )
        end
      end
    end
    
    initializer 'paperclip' do
      class << Paperclip
        def logger
          Rails.logger 
        end 
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