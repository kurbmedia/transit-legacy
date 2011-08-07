module Transit
  module Model
    
    module Topics
      extend ActiveSupport::Concern
      
      included do
        has_and_belongs_to_many :topics, inverse_of: :posts, autosave: true
        Topic.send(:has_and_belongs_to_many, :"#{self.name.pluralize.underscore}", inverse_of: :topics)
      end  
    end
    
  end
end