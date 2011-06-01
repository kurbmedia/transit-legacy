module Transit
  
  # Handles mapping models to controllers, as well as controller generation.
  class Mapping
    
    attr_accessor :class_name, :klass, :controller, :resource
    
    def initialize(mod)
      @class_name = mod.to_s.classify
      @resource   = mod.to_s.pluralize
      Transit.add_mapping(self)
      build
      self
    end
    
    def build      
      @klass = fetch_ref
      unless Transit.const_defined?(resource_controller)
        parent_controller = Class.new( Transit.const_get(controller_name) )
        Transit.const_set(resource_controller, parent_controller)
        parent_controller.send(:include, Transit::Controller::Actions)        
        @klass.subclasses.each do |sub|          
          sub_controller = "#{sub.to_s.pluralize}Controller"
          unless Transit.const_defined?(sub_controller)
            sub_controller_class = Class.new(parent_controller)
            Transit.const_set(sub_controller, sub_controller_class )
            parent_controller.send(:include, Transit::Controller::Actions)          
          end          
        end
      end
    end
    
    def controller_name
      @controller ||= "#{package_type.to_s.classify.pluralize}Controller"
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