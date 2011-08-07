require 'mongoid'
require 'active_support/deprecation'

module Transit
  module Model
    
    module Hooks
      
      def deliver_as(type)
        scope = type.to_s.classify
        include Transit::Package.const_get(scope)
        Transit.track(self, type.to_sym)
      end
      
      def deliver_with(*opts)
        opts.map(&:to_s).map(&:camelize).each do |t|
          if t.to_s.downcase.match(/owner/i)
            ActiveSupport::Deprecation.warn('deliver_with :owner has been changed and will be removed in 0.0.4. Please use deliver_with :ownership')
            t = "Ownership"
            self.delivery_options |= ['ownership', 'owner']
          end
          unless Transit::Model.const_defined?(t)
            raise Transit::Errors::ResourceNotFound.new("You called deliver_with #{t.underscore} but no resource called #{t} was found.")
          end
          include Transit::Model.const_get(t)
        end
        self.delivery_options |= opts.map!(&:to_s)
      end
      
      # Provide auto-incrementing functionality for any model
      def auto_increment
        include Transit::Model::AutoIncrement
      end
      
      # Provide attribute 'slugging' on any model
      def slug_with(field, callback = :before_create, callback_options = {})        
        define_method "generate_slug" do
          return true unless self.slug.to_s.blank?
          self.slug = self.send(field.to_sym).to_slug
        end
        self.send(:field, :slug, type: String)
        self.send(callback, :generate_slug, callback_options)
      end
      
    end
    
  end
end

Mongoid::Document::ClassMethods.class_eval do
  include Transit::Model::Hooks
  include Transit::Model::Paginator::ClassMethods
end
Mongoid::Criteria.send :include, Transit::Model::Paginator::Criteria
Mongoid::Document.send :include, Transit::Model::Paginator::Document