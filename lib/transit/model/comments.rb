module Transit
  module Model
    
    module Comments
      extend ActiveSupport::Concern
      
      included do        
        field :comment_count, :type => Integer, :default => 0
        has_many :comments, as: :commentable
      end
    end
    
  end
end