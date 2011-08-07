class Video < Transit::Context
  alias_attribute :source, :body
  
  def source
    body
  end
  
  def source=(src)
    body = src
  end
  
  def self.sources
    ['URL', 'Uploaded Video', 'YouTube', 'Vimeo', 'Ted'].collect{ |src| [src, src.underscore ] }
  end
  
  def video_type=(t)
    self.meta['video_type'] = t
  end
  
  def video_type
    self.meta['video_type']
  end
  
  def media_context?
    true
  end
  
  def to_js( attrs = {} )
    super({ source: source, type: video_type, ext: file_ext }.reverse_merge!(attrs))
  end
  
end