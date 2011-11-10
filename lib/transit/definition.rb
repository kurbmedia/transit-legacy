require 'active_support/lazy_load_hooks'
require 'active_support/ordered_options'

##
# Definitions represent the type of delivery method for a particular model.
# The core library includes a two definitions:
#   Post: which represents feed-style data such as blog posts or news articles. 
#   Page: which represents a static page which can contain multiple editable regions of content.
# 
module Transit
  module Definition

    autoload :Post,    'transit/definitions/post/base'
    autoload :Page,    'transit/definitions/page/base'
    autoload :Context, 'transit/definitions/context/base'
    autoload :Asset,   'transit/definitions/asset/base'
    
    module Hook
      ##
      # The deliver_as method creates a `definition` on a particular model. 
      # @param type [String,Symbol] The name of the definition to apply.
      # @usage Create a post model
      # 
      #   class Post < ActiveRecord::Base
      #     deliver_as :post
      #   end
      # 
      def deliver_as(type, options = {}) 
        scope, clean = type.to_s.classify, type.to_s.underscore
        unless Transit::Definition.const_defined?(scope)
          raise Transit::Errors::DefinitionNotFound.new("Definition not found: #{scope}")
        end
        
        self.send(:class_attribute, :delivery_options, :instance_writer => false)
        self.delivery_options ||= ::ActiveSupport::OrderedOptions.new
        delivery_options[clean] = ::ActiveSupport::OrderedOptions.new(options)

        include Transit::Definition.const_get(scope)          

        Transit::Schema.apply!(clean) do |attribute, opts|
          type = opts.delete(:type) || String
          apply_transit_schema(attribute, type, opts)
        end          
        
        Transit.run_definition_hooks(:"#{clean}", self)
        
      end
      
      ##
      # ORM's should override this method to perform particular schema functionality
      # 
      def apply_transit_schema(field, type, options = {})
        raise NotImplemented
      end
      
    end    
  end  
end