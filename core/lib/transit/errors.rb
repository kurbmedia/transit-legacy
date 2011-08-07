module Transit
  module Errors
  end
end

class Transit::Errors::PluginMissing < StandardError
end

class Transit::Errors::InvalidContext < StandardError
end