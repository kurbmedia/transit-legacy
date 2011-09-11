module Transit
  module Definition
    module Common
      
      ##
      # Tracks whether a model is "published" or not, using a `published` attribute.
      # Both pages and posts can exist in either a published or un-published state
      # 
      module PublishState
        extend ActiveSupport::Concern
        
        included do
          define_transit_attribute(:published, Boolean, :default => false)
        end
      end
      
    end
  end
end