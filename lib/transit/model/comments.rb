module Transit
  module Model
    
    module Comments
      extend ActiveSupport::Concern
      
      included do        
        field :comment_count, :type => Integer, :default => 0
        has_many :comments, as: :commentable
      end
      
      def has_comments?
        self.comment_count >= 1
      end
      
    end
    
  end
end