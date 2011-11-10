require 'transit'
require 'rails'

module Transit
  module Admin
    class Engine < Rails::Engine
      isolate_namespace Transit
      config.asset_path = "%s"
      
      require 'kaminari'
      
      paths['app/controllers'] << File.expand_path("../../../../app/controllers/transit", __FILE__)
      paths['app/views']       << File.expand_path("../../../../app/views/transit", __FILE__)
      paths['app/helpers']     << File.expand_path("../../../../app/helpers/transit", __FILE__)
      
      ActiveSupport.on_load(:active_record) do
        ActiveRecord::Base.send(:extend, Transit::Admin::Tableizer) 
      end
      
      ActiveSupport.on_load(:action_view) do
        require File.expand_path("../../../../app/helpers/transit", __FILE__) << "/admin_helper"
        include Transit::AdminHelper
      end
      
      if defined?(Mongoid)
        Mongoid::Document::ClassMethods.class_eval do
          include Transit::Admin::Tableizer
        end
      end
      
    end
  end
end

require 'transit/admin/routing'