class Text < Transit::Context  
  def deliver
    self.body.to_s.html_safe
  end
end