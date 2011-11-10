module Transit
  module Plugin    
    module Comments
      extend ActiveSupport::Concern      
      included do
        has_many :comments, :as => :commentable
        apply_transit_schema(:comment_count, Integer, :default => 0)
      end
    end    
  end
end