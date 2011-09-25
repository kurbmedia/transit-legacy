require 'mime/types'

module Transit
  class Asset
    deliver_as :asset
    belongs_to :assetable, :polymorphic => true
        
    has_attached_file :file
    before_post_process :skip_processing_unless_image

    def skip_processing_unless_image
      if !(file.content_type =~ %r{^(image|(x-)?application)/(x-png|pjpeg|jpeg|jpg|png|gif)$})
        return false 
      end
    end

  end
end