module Transit
  module Package
    
    module Page
      extend ActiveSupport::Concern
      
      included do
        field :name,        :type => String
        field :url,         :type => String
        field :keywords,    :type => Array
        field :description, :type => String
        
        scope :published, where(:published => true)
      end
    end
    
  end
end