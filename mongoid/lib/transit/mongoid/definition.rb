module Transit
  module Definition
    module Hook      
      def define_transit_attribute(name, type, options)
        field name, options.merge(:type => type)
      end      
    end
  end
end