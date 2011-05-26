require 'rails'
require 'active_support'
require 'mongoid'

module Transit
  
  autoload :Package, 'transit/package'
  autoload :Context, 'transit/context'
  
  module Helpers
    autoload :ControllerHelpers,  'transit/helpers/controller_helpers'
    autoload :ModelHelpers,       'transit/helpers/model_helpers'
  end
  
  module Errors
    autoload :InvalidContext, 'transit/errors/invalid_context'
  end
  
  DESCRIPTIONS = {}
  CONTROLLERS  = []
  
  def self.add_controller(klass)
    CONTROLLERS << klass.to_s.classify.pluralize
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
require 'transit/rails/engine'
require 'transit/rails/routing'