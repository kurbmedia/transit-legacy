class Video < Transit::Context
  alias_attribute :source, :body
  
  def self.sources
    ['URL', 'Uploaded Video', 'YouTube', 'Vimeo', 'Ted'].collect{ |src| [src, src.underscore ] }
  end
  
  def video_type=(t)
    self.meta['video_type'] = t
  end
  
  def video_type
    self.meta['video_type']
  end
  
  def data
    { source: source, type: video_type, ext: file_ext }
  end
  
end