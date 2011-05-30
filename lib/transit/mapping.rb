module Transit
  
  # Handles mapping models to controllers, as well as controller generation.
  class Mapping
    
    attr_accessor :class_name, :klass, :controller, :resource
    
    def initialize(mod)
      @class_name = mod.to_s.classify
      @resource   = mod.to_s.pluralize
      Transit.add_mapping(self)
      self
    end
    
    def build      
      @klass      = fetch_ref      
      @controller = package_type.to_s.classify.pluralize      
    end
    
    def controller_name
      "#{@controller}Controller"
    end
        
    def fetch_ref
      @ref ||= ActiveSupport::Dependencies.constantize(@class_name)
    end
    
    def package_type
      @klass.transit_config[:template]
    end
    
    def resource_controller
      "#{@resource.classify.pluralize}Controller"
    end
        
  end
  
end