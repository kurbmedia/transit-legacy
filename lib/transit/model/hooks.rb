require 'transit/post'
require 'transit/page'

module Transit
  module Model
    
    module Hooks
      
      def deliver_as(type)
        scope = type.to_s.classify
        include Transit.const_get(scope)
      end
      
      def deliver_with(*opts)
        opts.map(&:to_s).map(&:classify).each do |t|
          begin
            include Transit::Model.const_get(t.pluralize)
          rescue NameError
            raise Transit::Errors::ResourceNotFound("You called deliver_with #{t.underscore} but no resource called #{t.pluralize} was found.")
          end
        end
      end
      
    end
    
  end
end

Mongoid::Document::ClassMethods.class_eval do
  include Transit::Model::Hooks
end