require 'transit/definitions/asset/identification'

module Transit::Definition
  module Asset
    include Identification
    extend ActiveSupport::Concern
    
    included do
      before_save   :set_default_name
      before_create :set_default_file_type
      if self.respond_to?(:descends_from_active_record?)
        serialize :meta 
      end
    end
    
    ##
    # Loops through all paperclip processing styles and generates 
    # an array of urls for the attachment.
    # 
    def file_urls
      return { :original => file.url(:original) } unless image?
      file.styles.keys.inject({}){ |hash, style|  hash.merge!(style => file.url(style)) }
    end
    
    ##
    # Convenience method to return the created_at time in a date format.
    # 
    def timestamp
      self.created_at.strftime("%B %d, %Y")
    end
    
    private
    
    ##
    # Allow assigning a name attribute to an asset for easier identification
    # 
    def set_default_name
      return true unless self.respond_to?(:name) && self.name.to_s.blank?
      self.name = self.file_file_name.to_s
    end
    
  end
end

Transit::Schema.add(:assets, {
  :name               => { :type => String },
  :meta               => { :type => Hash, :default => {} },
  :file_file_name     => { :type => String },
  :file_content_type  => { :type => String },
  :file_file_size     => { :type => Integer },
  :file_updated_at    => { :type => DateTime },
  :file_fingerprint   => { :type => String },
  :file_type          => { :type => String }  
})