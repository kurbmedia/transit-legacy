module Transit
  module Package
    
    module Page
      extend ActiveSupport::Concern
      
      included do
        field :name,        :type => String
        field :url,         :type => String
        field :keywords,    :type => Array
        field :description, :type => String
      end
    end
    
  end
end