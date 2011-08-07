require 'active_support/inflector'

module Transit
  module Controller    
    class Generator
      
      attr_accessor :types
      
      def initialize(*klasses)
        @types = klasses.map(&:to_s)
      end
      
      def generate!
        @types.map(&:to_sym).each do |type|
          typed_classes = Transit.lookup(type).dup.map!(&:constantize)
          
          typed_classes.each do |sup|          
            sup.subclasses.each do |klass|              
              controller_name = to_controller(klass) 
              next if Transit.const_defined?( controller_name, false )
              eval "class Transit::#{controller_name} < Transit::#{parent_controller(sup)}; end"
              ActiveSupport::Dependencies::Reference.store(Transit.const_get("#{controller_name}"))
            end
          end
          
        end
      end
      
      def parent_controller(str)
        p = ActiveSupport::Inflector.pluralize(str.to_s.classify)
        "#{p}Controller"
      end
      
      def to_controller(str)
        (ActiveSupport::Inflector.pluralize(str.to_s.classify) << "Controller")
      end      
    end    
  end
end