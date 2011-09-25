module Transit
  module Schema
    @schemas = {}
    
    def self.add(name, options = {})
      name = name.to_sym
      @schemas[name] ||= ActiveSupport::OrderedHash.new
      @schemas[name].merge!(options)
    end
    
    def self.apply!(name, &block)
      name = name.to_sym
      if @schemas[name]
        @schemas[name].each do |attribute, options|
          yield attribute, options
        end
      end
    end
    
  end
end