require 'rails'
require 'active_support'
require 'mongoid'

module Transit
  
  autoload :Package, 'transit/package'
  autoload :Context, 'transit/context'
  
  module Helpers
    autoload :ControllerHelpers,  'transit/helpers/controller_helpers'
  end
  
  module Errors
    autoload :InvalidContext, 'transit/errors/invalid_context'
  end
  
end

require 'transit/package'
require 'transit/rails/engine'
require 'transit/rails/routing'