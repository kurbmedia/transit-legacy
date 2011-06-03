class Video < Transit::Context
  alias_attribute :source, :body
  
  def self.sources
    ['Uploaded Video', 'YouTube', 'Vimeo', 'Ted'].collect{ |src| [src, src.underscore ] }
  end
  
end