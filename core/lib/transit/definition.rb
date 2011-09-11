require 'active_support/lazy_load_hooks'

##
# Definitions represent the type of delivery method for a particular model.
# The core library includes a two definitions:
#   Post: which represents feed-style data such as blog posts or news articles. 
#   Page: which represents a static page which can contain multiple editable regions of content.
# 
module Transit
  module Definition
    extend ActiveSupport::Autoload    

    eager_autoload do
      autoload :Post,   'transit/definitions/post/base'
      autoload :Page,   'transit/definitions/page/base'
      autoload :Common, 'transit/definitions/common'
    end
    
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
      def deliver_as(type)        
        scope = type.to_s.classify
        begin
          include Transit::Definition.const_get(scope)
          Transit.run_definition_hooks(:"#{type.to_s.underscore}", self)
        rescue LoadError
          raise Transit::Errors::DefinitionNotFound.new("Definition not found: #{scope}")
        end      
      end
      
      ##
      # ORM's implement this method to define attributes for particular 
      # definition types. For instance, in mongoid, this calls the `field` method.
      # In ActiveRecord it defines attributes to be added in a Migration
      # 
      # @usage Implementation in mongoid
      # 
      #   def define_transit_attribute(name, type, options = {})
      #     field name, options.merge(type: type)
      #   end
      # 
      def define_transit_attribute(name, type, options = {})
        raise NotImplementedError
      end
      
    end    
  end  
end