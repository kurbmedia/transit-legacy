require 'mime/types'

module Transit
  class Asset
    include Paperclip::Glue
    has_attached_file :file
    before_post_process :skip_processing_unless_image

    def skip_processing_unless_image
      if !(file.content_type =~ %r{^(image|(x-)?application)/(x-png|pjpeg|jpeg|jpg|png|gif)$})
        return false 
      end
    end

  end
end