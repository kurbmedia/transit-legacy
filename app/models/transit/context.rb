module Transit
  class Context
    
    def self.inherited(klass)
      super
      klass.instance_eval do
        define_method(:__ensure_subclass_only){ true }
      end
    end
    include Transit::Models::Context
    before_save :__ensure_subclass_only
    
    def __ensure_subclass_only
      raise Transit::Errors::InvalidContext.new("Can not save an instance of Transit::Context directly. Each context must be a subclass of Transit::Context")
    end
    
  end
end