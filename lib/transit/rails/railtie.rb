module Transit
  class Railtie < Rails::Railtie
    
    initializer 'transit.integration' do |app|
      app.config.responders.flash_keys = [ :success, :error ]
      app.config.assets.precompile << 'transit.css'
      app.config.assets.precompile << 'transit.js'
    end

  end
end