module Transit
  module Plugin    
    module Comments
      extend ActiveSupport::Concern      
      included do
        has_many :comments
        apply_transit_schema(:body, String, {})
      end
    end    
  end
end