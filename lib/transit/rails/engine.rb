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
    initializer 'transit.generate_controllers', :after => :build_middleware_stack do
      Transit::Post.subclasses.each do |sub|
        controller_name = "#{sub.to_s.pluralize}Controller"
        unless Transit.const_defined?(controller_name)
          Transit.const_set(controller_name, Class.new( Transit::PostsController) )
          ActiveSupport::Dependencies::reference(Transit.const_get(controller_name))
        end
      end
      
      Transit::Page.subclasses.each do |sub|
        controller_name = "#{sub.to_s.pluralize}Controller"
        unless Transit.const_defined?(controller_name)
          Transit.const_set(controller_name, Class.new( Transit::PagesController) )
          ActiveSupport::Dependencies::reference(Transit.const_get(controller_name))
        end
      end
    end

    initializer 'transit.controller_hooks' do
      ActiveSupport.on_load(:after_initialize) do
        TransitController.send(:include, Transit::Controller::Routing)
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