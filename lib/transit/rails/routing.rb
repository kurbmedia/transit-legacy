module ActionDispatch::Routing
  class Mapper
    
    def transit(*models)
      options = models.extract_options!
      
      Transit::Engine.routes.draw do
        models.map(&:to_s).each do |mod|
          mapping = Transit::Mapping.new(mod)
          resources mapping.resource do
            resources :contexts, :only => [:new, :destroy]
          end
        end
      end      
      mount Transit::Engine => (options[:mount_on] || "/transit")
      
    end
    
  end
end