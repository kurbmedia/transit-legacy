module Transit
  module Helpers
    
    module ModelHelpers
      extend ActiveSupport::Concern
      
      included do
        field :uid, :type => Integer
        # Increment the sql_id each time to have a sql (auto_increment) style id for each post.
        before_create :generate_uid, :on => :create
      end
      
      def generate_uid
        return true unless self.uid.nil?        
        ref = self.class.collection.name.singularize.classify.constantize
        self.uid = ref.max(:uid).to_i + 1
      end
      
      def timestamp
        return "" if self.created_at.nil?
        self.created_at.strftime("%B %d, %Y")
      end
      
    end
  end
end