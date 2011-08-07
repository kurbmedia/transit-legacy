module Transit
  module Package
        
    module Page
      extend ActiveSupport::Concern
      
      included do
        class_attribute :delivers_as, instance_writer: false
        self.deliver_as = :page
        apply_page_schema!
        apply_contexts!        
      end

    end    
  end
end