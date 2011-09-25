module Transit::Definition
  module Post
    module Validations
      def self.included(model)
        model.class_eval do          
          validate :title, :post_date, :presence => true          
        end
      end
    end
  end
end