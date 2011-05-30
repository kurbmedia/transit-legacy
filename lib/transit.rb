require 'rails'
require 'active_support'
require 'mongoid'

module Transit
  
  autoload :Package, 'transit/package'
  autoload :Context, 'transit/context'
  
  module Model
    autoload :Helpers,  'transit/model/helpers'
  end
  
  module Controller
    autoload :Actions,  'transit/controller/actions'
    autoload :Helpers,  'transit/controller/helpers'
  end
  
  module Errors
    autoload :InvalidContext, 'transit/errors/invalid_context'
  end
  
  DESCRIPTIONS = {}
  
  # Store an array of controller mappings
  mattr_accessor :mappings
  @@mappings = []

  def self.add_mapping(obj)
    @@mappings << obj
  end

  def self.contexts
    Transit::Context.subclasses.map(&:to_s).uniq
  end
  
  def self.track(klass, template)
    DESCRIPTIONS[template] ||= []
    DESCRIPTIONS[template] |= [klass.to_s]
  end
  
  def self.lookup(template)
    DESCRIPTIONS[template] ||= []
  end
  
end

require 'transit/package'
require 'transit/mapping'
require 'transit/rails/engine'
require 'transit/rails/routing'