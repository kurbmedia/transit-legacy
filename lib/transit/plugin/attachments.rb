require 'paperclip'

module Transit
  module Plugin
    module Attachments
      extend ActiveSupport::Concern
      
      included do
        include Paperclip::Glue
      end
      
      # Convenience method for only finding assets that are images
      def images
        self.assets.where(asset_type: 'image')
      end

      def image?
        image.file?
      end

      # Convenience method for only finding the assets that are files
      def files
        self.assets.exclude(asset_type: 'image')
      end

      module ClassMethods
        # Convenience method for Paperclip's has_attached_file to ensure fields also exist.
        def attach(name, options = {})          
          options.reverse_merge!(original: '1500x1500>') if options[:styles].present?            
          has_attached_file name, options
        end
      end
      
    end    
  end
end