class Audio < Transit::Context
  alias_attribute :source, :body
  
  def to_js( attrs = {} )
    super({ source: source, ext: file_ext }.reverse_merge!(attrs))
  end
  
end