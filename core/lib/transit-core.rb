require 'active_support'
require 'active_support/inflector'
require 'transit/support'
require 'transit/config'
require 'transit/package'
require 'transit/errors'
require 'transit/plugin'
require 'transit/rails/engine'
require 'transit/rails/routing'

module Transit

  module Controller
    autoload :Generator,  'transit/controller/generator'
  end
  
  module Errors
    autoload :InvalidContext,   'transit/errors/invalid_context'
    autoload :ResourceNotFound, 'transit/errors/resource_not_found'
  end
  
end