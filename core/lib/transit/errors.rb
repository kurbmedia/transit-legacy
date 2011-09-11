module Transit
  module Errors
    
    class PluginMissing < ::StandardError
    end

    class InvalidContext < ::StandardError
    end
    
    class DefinitionNotFound < ::StandardError
    end
    
  end
end

