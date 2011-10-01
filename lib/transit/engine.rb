module Transit
  class Engine < ::Rails::Engine
    # isolate_namespace Transit
    # config.asset_path = "%s"
    
    paths['app/models'] << File.expand_path("../../../app/models/transit/contexts")
    paths['app/helpers'] << File.expand_path("../../../app/helpers")
    paths['app/views'] << File.expand_path("../../../app/views")
    
  end
end

require 'transit/routing'