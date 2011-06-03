module Transit
  module Model
    module Attachments
      extend ActiveSupport::Concern
      
      included do
        include Paperclip::Glue
      end
      
      #Convenience method for only finding the assets that are images
      def images
        self.assets.find_all{ |asset| asset.image? }
      end

      def image?
        image.file?
      end

      # Convenience method for only finding the assets that are files
      def files
        self.assets.reject{ |asset| asset.image? }
      end
      
    end
    
  end
end