require 'active_support/all'
require 'transit/version'
require 'transit/hooks'
require 'transit/schema'
require 'transit/plugin'
require 'transit/errors'
require 'transit/extensions/all'
require 'transit/engine'

module Transit
  mattr_accessor :orm
  
  @contexts = ActiveSupport::OrderedHash.new
  
  ##
  # Register a context type. 
  # @param [Symbol] name The name of the context class to register.
  # @params [Hash] options A hash of options to include with the context
  # @option [String] type A string representing native ruby class that best specifies how the context is delivered.
  # 
  def self.register_context(name, options)
    @contexts[name] = options
  end
  
  def self.version
    VERSION
  end
  
end