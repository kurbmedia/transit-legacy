module Transit
  module Model
    
    module Topics
      extend ActiveSupport::Concern
      
      included do
        has_and_belongs_to_many :topics
        Topic.send(:has_and_belongs_to_many, :"#{self.name.pluralize.underscore}")
      end  
    end
    
  end
end