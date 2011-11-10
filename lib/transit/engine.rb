module Transit
  class Engine < ::Rails::Engine

    paths['app/models']  << File.expand_path("../../../app/models/transit/contexts")
    paths['app/helpers'] << File.expand_path("../../../app/helpers")
    paths['app/views']   << File.expand_path("../../../app/views")
    paths['app/assets']  << File.expand_path("../../../app/assets")

    initializer 'transit.setup_models', :before => :eager_load! do |app|
      Transit::Context.send(:deliver_as, :context)
      Transit::Asset.send(:deliver_as, :asset)
    end
    
  end
end

require 'transit/routing'