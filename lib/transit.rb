require 'rails'
require 'active_support'
require 'mongoid'

module Transit
  
  module Models
    autoload :Package, 'transit/models/package'
    autoload :Context, 'transit/models/context'
  end
  
end

require 'transit/rails/engine'