require 'transit/context'

class Audio < Transit::Context
  alias_attribute :source, :body
  
  def media_context?
    true
  end
  
end