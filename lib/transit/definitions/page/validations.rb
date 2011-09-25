module Transit::Definition
  module Page
    module Validations
      def self.included(model)
        model.class_eval do          
          validate :title, :keywords, :description, :url, :presence => true          
        end
      end
    end
  end
end