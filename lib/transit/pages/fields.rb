module Transit
  module Pages
    module Fields
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