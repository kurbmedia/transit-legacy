class Audio < Transit::Context
  alias_attribute :source, :body
  
  def data
    { source: source, ext: file_ext }
  end
  
end