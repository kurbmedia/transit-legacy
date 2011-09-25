require 'active_record'
require 'transit'
require 'transit/definition'

Transit.orm = :active_record

module Transit
  module ActiveRecord
    module Schema
      def apply_transit_schema(name, type, options)
        field name, options.merge!(:type => type)
      end      
    end
    module Context
      def create_context_association!        
        has_many :contexts, :as => :package, :class_name => "Transit::Context"
        accepts_nested_attributes_for :contexts
      end
    end
  end
end


ActiveRecord::Base.send(:include, Transit::Definition::Hook)
ActiveRecord::Base.send(:include, Transit::ActiveRecord::Context)
ActiveRecord::Base.send(:include, Transit::Plugin)
ActiveRecord::ConnectionAdapters::Table.send :include, Transit::ActiveRecord::Schema
ActiveRecord::ConnectionAdapters::TableDefinition.send :include, Transit::ActiveRecord::Schema


Transit.on_definition(:context) do
  serialize :meta
  has_many :packages, :polymorphic => true  
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

module Transit
  class Context
    extend ::ActiveRecord::Base
    serialize :meta    
  end
end

module Transit
  class Asset
    extend ActiveRecord::Base
  end
end