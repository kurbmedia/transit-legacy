class Video < Transit::Context
  
  field :poster, type: String
  alias_attribute :source, :body
  
  def self.sources
    ['URL', 'Upload', 'YouTube', 'Vimeo', 'Ted'].collect{ |src| [src, src.underscore ] }
  end
  
  def video_type=(t)
    self.meta['video_type'] = t
  end
  
  def video_type
    self.meta['video_type']
  end
  
  def source
    return "" if self.body.to_s.blank?
    source_method = :"#{video_type.downcase}_source"
    return self.body if video_type.to_s.blank? || !respond_to?(source_method)
    send(source_method)
  end
  
  private
  
  def youtube_source
    return self.body if self.body.match(/youtube\.com/i)
    "http://www.youtube.com/v/#{self.body}"
  end
  
  def upload_source
    asset = Transit::Asset.where(:_id => self.body).first
    return "" if asset.nil?
    asset.file.url(:original, false)
  end
  
end