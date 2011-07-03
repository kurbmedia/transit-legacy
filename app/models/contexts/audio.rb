class Audio < Transit::Context
  alias_attribute :source, :body
  
  def media_context?
    true
  end
  
  def to_js( attrs = {} )
    super({ src: source }.reverse_merge!(attrs))
  end
  
end