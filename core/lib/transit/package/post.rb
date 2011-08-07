module Transit
  module Package
        
    module Post
      extend ActiveSupport::Concern
      
      included do
        class_attribute :deliver_as, instance_writer: false
        self.deliver_as = :post
        apply_post_schema!
        apply_contexts!        
      end

    end
    
  end
end