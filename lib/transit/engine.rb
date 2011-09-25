module Transit
  class Engine < ::Rails::Engine
    isolate_namespace Transit
    paths['app/models'] << File.expand_path("../../../app/models/transit/contexts")
  end
end