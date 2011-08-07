require 'paperclip'

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
      
      # Override to show a "default image" in the admin.
      def preview_image_url
        nil
      end
      
      module ClassMethods
        ##
        # Convenience method for Paperclip's has_attached_file to ensure fields also exist.
        # 
        def attach(name, options = {})
          
          if options[:styles].present?
            options.reverse_merge!(original: '1500x1500>')
          end
          
          has_attached_file name, options
          field :"#{name.to_s}_file_name",     :type => String
          field :"#{name.to_s}_content_type",  :type => String
          field :"#{name.to_s}_file_size",     :type => Integer
          field :"#{name.to_s}_updated_at",    :type => Time
          field :"#{name.to_s}_fingerprint",   :type => String
          
        end        
             
      end
      
    end
    
  end
end