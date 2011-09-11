module Transit
  module Plugin
    module Ownership      
      extend ActiveSupport::Concern      
      included do
        belongs_to :user
        User.send(:has_many, :"#{self.name.pluralize.underscore}")
      end      
    end
  end
end