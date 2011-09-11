require 'transit-core'
require 'rails'

module Transit
  module Admin
    class Engine < Rails::Engine
      isolate_namespace Transit
    end
  end
end