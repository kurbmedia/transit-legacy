require "transit/admin/version"
require "transit-core"

module Transit
  module Controller
    autoload :Generator, 'transit/controller/generator'
  end
end

require 'transit/admin'
require 'transit/admin/engine'
require 'transit/admin/routing'
