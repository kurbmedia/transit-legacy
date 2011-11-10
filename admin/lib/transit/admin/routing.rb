require 'transit-admin'

module ActionDispatch::Routing
  class Mapper
    class_attribute :transit_engine_mounted
    
    def manage_deliveries_for(*args)
      
      options       = args.extract_options!
      mount_as_path = (options.delete(:mount_on) || "/transit")
      auth_method   = options.delete(:authenticate)
      unless auth_method.nil?
        Transit::Admin.authenticate_via = auth_method
      end
      
      Transit::Admin::Engine.routes.draw do      
        args.map(&:to_s).each do |mod|
          #Transit::Admin.add_mapping(mod)
          resources mod.pluralize, options do
            resources :contexts
          end
        end
      end  
      
      unless transit_engine_mounted == true  
        mount Transit::Admin::Engine => mount_as_path, :as => :transit
        transit_engine_mounted = true
      end
      
    end
    
  end
end