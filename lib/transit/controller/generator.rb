require 'active_support/inflector'

module Transit
  module Controller
    
    class Generator
      
      attr_accessor :scopes
      
      def initialize(*klasses)
        @scopes = klasses.map(&:to_s)
      end
      
      def generate!
        @scopes.map(&:classify).each do |sup|
          Transit.const_get(sup).subclasses.each do |klass|            
            controller_name = to_controller(klass) 
            next if Transit.const_defined?( controller_name, false )            
            new_klass = Class.new( parent_controller(sup) )
            Transit.const_set( controller_name, new_klass)
            ActiveSupport::Dependencies::reference(Transit.const_get(controller_name))
          end
        end
      end
      
      def parent_controller(str)
        p = ActiveSupport::Inflector.pluralize(str.to_s.classify)
        p = Transit.const_get("#{p}Controller")
      end
      
      def to_controller(str)
        (ActiveSupport::Inflector.pluralize(str.to_s.classify) << "Controller")
      end
      
    end
    
  end
end