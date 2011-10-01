require 'transit'
require 'rails'

module Transit
  module Admin
    class Engine < Rails::Engine
      # isolate_namespace Transit
      # config.asset_path = "%s"
      
      paths['app/controllers'] << File.expand_path("../../../../app/controllers/transit", __FILE__)
      paths['app/views']       << File.expand_path("../../../../app/views/transit", __FILE__)
      paths['app/views']       << File.expand_path("../../../../app/views/kaminari", __FILE__)
      
      ActiveSupport.on_load(:active_record) do
        ActiveRecord::Base.send(:extend, Transit::Admin::Tableizer) 
      end
      
      if defined?(Mongoid)
        Mongoid::Document::ClassMethods.class_eval do
          include Transit::Admin::Tableizer
        end
      end
      
    end
  end
end