require 'mime/types'

module Transit::Definition
  module Asset
    module Identification
      
      def image?
        (self.file_content_type =~ %r{^(image|(x-)?application)/(x-png|pjpeg|jpeg|jpg|png|gif)$})
      end
      
      def video?
        (self.file_content_type =~ %r{^(video)/.*$})
      end
      
      def audio?
        (self.file_content_type =~ %r{^(audio)/.*$})
      end
      
      private
      
      def set_default_file_type
        self.file_type = ::MIME::Types.type_for(self.file_file_name.to_s).first.media_type
      end
      
    end
  end
end