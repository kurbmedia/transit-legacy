require 'mime/types'

module Transit
  class Asset
  
    include Mongoid::Document
    include Mongoid::Timestamps
    include Paperclip::Glue
    store_in :assets
    auto_increment
  
    field :name,                type: String
    field :meta,                type: Hash
    field :file_file_name,      type: String
    field :file_content_type,   type: String
    field :file_file_size,      type: Integer
    field :file_updated_at,     type: DateTime
    field :file_fingerprint,    type: String
    field :file_type,           type: String
  
    belongs_to    :assetable, :polymorphic => true
    before_save   :set_default_name
    before_create :set_file_type
  
    has_attached_file :file, Transit::Config.assets  
    
    # Determine if this asset is an image
    def image?
      (self.file_content_type =~ %r{^(image|(x-)?application)/(x-png|pjpeg|jpeg|jpg|png|gif)$})
    end

    # Provide a way to get a list of all urls for the attachment
    def file_urls
      return { :original => file.url(:original) } unless image?
      file.styles.keys.inject({}){ |hash, style|  hash.merge!(style => file.url(style)) }
    end

    def timestamp
      self.created_at.strftime("%B %d, %Y")
    end
    
    def before_post_process
      image?
    end

    private

    def set_default_name
      return true unless self.name.to_s.blank?
      self.name = self.file_file_name
    end
    
    def set_file_type
      self.file_type = ::MIME::Types.type_for(self.file_file_name.to_s).first.media_type
    end
  
  end
end