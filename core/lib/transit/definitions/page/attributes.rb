module Transit
  module Definition
    
    module Page
      ##
      # Defines attributes belonging to page models.
      #
      module Attributes
        extend ActiveSupport::Concern
        
        included do
          define_transit_attribute(:title, String, :default => "")
          define_transit_attribute(:url, String, :default => nil)
          define_transit_attribute(:description, String, :default => "")
          define_transit_attribute(:keywords, Array, :default => [])
        end
      end
            
    end
  end
end