module Transit
  module Definition
    module Post
      ##
      # Defines attributes belonging to post models.
      # 
      module Attributes
        extend ActiveSupport::Concern

        included do
          define_transit_attribute(:title, String)
          define_transit_attribute(:post_date, DateTime)
          define_transit_attribute(:slug, String)
          define_transit_attribute(:teaser, String)
          define_transit_attribute(:default_teaser, String)
        end
      end
      
    end
  end
end