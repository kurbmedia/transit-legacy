class Audio < Transit::Context
  alias_attribute :source, :body
  
  def source
    body
  end
  
  def source=(src)
    body = src
  end
  
  def media_context?
    true
  end
  
  def to_js( attrs = {} )
    super({ source: source, ext: file_ext }.reverse_merge!(attrs))
  end
  
end