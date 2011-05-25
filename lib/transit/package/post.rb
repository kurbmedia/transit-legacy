module Transit
  module Package
    
    module Post
      extend ActiveSupport::Concern
      
      included do
        field :title,       :type => String
        field :post_date,   :type => Time
        field :slug,        :type => String
        
        modded_with :sluggable, :fields => :title, :as => :slug        
      end
    end
    
  end
end