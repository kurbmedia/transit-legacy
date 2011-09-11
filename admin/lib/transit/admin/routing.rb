module ActionDispatch::Routing
  ##
  # Adds support for routing definitions via a `transit` method.
  # 
  class Mapper    
    def transit(*args)
      options = args.extract_options!      
      Transit::Engine.routes.draw do      
        args.map(&:to_s).map(&:pluralize).each do |mod|
          Transit.add_mapping(mod)
          resources mod do
            resources :contexts
          end
        end
      end      
      mount Transit::Engine => (options[:mount_on] || "/transit")
    end    
  end
end