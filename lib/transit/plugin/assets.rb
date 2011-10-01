module Transit
  module Plugin    
    module Assets
      extend ActiveSupport::Concern      
      included do
        has_many :assets, as: :assetable, class_name: "Transit::Asset"
      end
      
      # Convenience method for only finding assets that are images
      def images
        self.assets.where(:asset_type => 'image')
      end
      # Convenience method for only finding the assets that are files
      def files
        self.assets.excludes(:asset_type => 'image')
      end
      
    end    
  end
end