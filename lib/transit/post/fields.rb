module Transit
  module Post
    module Fields
      extend ActiveSupport::Concern
      
      included do
        field :title,       :type => String
        field :post_date,   :type => Date
        field :slug,        :type => String
        field :teaser,      :type => String
        field :published,   :type => Boolean, :default => false
        
        scope :published, where(:published => true, :post_date.lte => Date.today)
      end      
      
    end
  end
end