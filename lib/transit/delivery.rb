module Transit
  module Delivery
    
    def transit(*contexts)
      include Transit::Models::Package
      contexts.map!(&:to_sym).each do |mod|
        embeds_many(mod)
      end
      self.transit_contexts |= contexts
    end
    
    def transit_context(*models)
      include Transit::Models::Context
      models.map!(&:to_sym).each do |mod|
        embedded_in(mod)
      end
      self.transit_packages |= models
    end
    
  end
end

Mongoid::Document::ClassMethods.class_eval do
  include Transit::Delivery
end
