require 'rails'

module Transit
  module Social
    class Engine < ::Rails::Engine
      
      initializer 'transit.social_orm', :after => :eager_load! do
        if defined?(Mongoid)
          require 'transit/social/mongoid'
        end
      end
      
      ActiveSupport.on_load(:active_record) do
        require 'transit/social/active_record'
      end
      
    end
  end
end