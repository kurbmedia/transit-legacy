module Transit
  class Engine < ::Rails::Engine
    isolate_namespace :Transit
    app.paths['app/models'] << File.expand_path("../../../app/models/transit", __FILE__)
  end
end