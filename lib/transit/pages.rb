module Transit
  module Pages
    
    autoload :Fields,       'transit/pages/fields'
    
    extend ActiveSupport::Concern
    
    included do
      include Transit::Pages::Fields
    end
    
    def timestamp
      return "" if self.post_date.nil?
      self.post_date.strftime("%B %d, %Y")
    end
  
  end
end