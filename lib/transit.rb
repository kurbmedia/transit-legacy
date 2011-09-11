require 'active_support/all'
require 'transit/version'
require 'transit/hooks'

module Transit
  include Hooks
  
  def self.version
    VERSION
  end
end