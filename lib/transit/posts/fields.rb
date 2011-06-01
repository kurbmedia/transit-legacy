module Transit
  module Posts
    module Fields
      extend ActiveSupport::Concern
      
      included do
        field :title,       :type => String
        field :post_date,   :type => Date
        field :slug,        :type => String
        field :teaser,      :type => String
      end      
      
    end
  end
end