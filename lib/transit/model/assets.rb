module Transit
  module Model
    
    module Assets
      extend ActiveSupport::Concern
      
      included do
        has_and_belongs_to_many :assets, as: :assetable, class_name: "Transit::Asset"
      end
      
    end
    
  end
end