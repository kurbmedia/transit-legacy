require 'mongoid'
require 'transit'
require 'transit/definition'

Transit.orm = :mongoid

module Transit
  module Mongoid
    module Schema
      def apply_transit_schema(name, type, options)
        field name, options.merge!(:type => type)
      end
    end
    module Context
      ##
      # Compatibility with Active Record
      # 
      def inheritance_column
        return :_type
      end
      
      def create_context_association!        
        embeds_many :contexts, :as => :package, :class_name => "Transit::Context"
        accepts_nested_attributes_for :contexts        
      end
    end
  end
end

require 'transit/plugin/auto_increment'

Mongoid::Document::ClassMethods.class_eval do
  include Transit::Definition::Hook
  include Transit::Plugin
  include Transit::Mongoid::Context
  include Transit::Mongoid::Schema
  include Transit::Plugin::AutoIncrement
end

Transit.on_definition(:context) do
  embedded_in :package, :polymorphic => true
end

Transit.on_definition(:asset) do
  store_in :assets
  begin
    include ::Paperclip::Glue  
  rescue LoadError
  end
end

Transit.on_definition(:post) do
  deliver_with :auto_increment
end

Transit.on_definition(:page) do
  deliver_with :auto_increment
end

require 'transit/orm/mongoid/models'