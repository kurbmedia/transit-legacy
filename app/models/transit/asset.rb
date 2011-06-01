module Transit
  class Asset
  
    include Mongoid::Document
    include Mongoid::Timestamps
    include Paperclip::Glue
    store_in :assets
  
    field :name,                :type => String
    field :meta,                :type => Hash
    field :uid,              :type => Integer
    field :file_file_name,     :type => String
    field :file_content_type,  :type => String
    field :file_file_size,     :type => Integer
    field :file_updated_at,    :type => DateTime
  
    has_and_belongs_to_many :posts, :class_name => "Transit::Post"
    has_and_belongs_to_many :pages, :class_name => "Transit::Page"
    
    before_create :generate_uid
    before_save :set_default_name
  
    has_attached_file :file,
      :styles => {
        :full     => "475x>",
        :thumb    => "50x50#",
        :small    => "100x100#",
        :medium   => "300x>",
        :original => "1500x1500>" # Resize the original to avoid storing huge images on S3
      },    
      :path => ":rails_root/public/system/assets/:uid/:style.:extension",
      :url  => "/system/assets/:uid/:style.:extension",
      :default_style => :full
  
    # Determine if this asset is an image
    def image?
      (self.file.content_type =~ %r{^(image|(x-)?application)/(x-png|pjpeg|jpeg|jpg|png|gif)$})
    end

    # Provide a way to get a list of all urls for the attachment
    def file_urls
      return { :original => file.url(:original) } unless image?
      file.styles.keys.inject({}){ |hash, style|  hash.merge!(style => file.url(style)) }
    end

    def timestamp
      self.created_at.strftime("%B %d, %Y")
    end

    private

    def generate_uid
      return true unless self.uid.nil?
      self.uid = Asset.max(:uid).to_i + 1
    end

    def set_default_name
      return true unless self.name.to_s.blank?
      self.name = self.file_file_name
    end
  
  end
end