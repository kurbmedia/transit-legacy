module Transit
  module Pages
    
    autoload :Fields,       'transit/pages/fields'
    
    extend ActiveSupport::Concern
    
    included do
      include Transit::Pages::Fields
      embeds_many :contexts, :as => :package, :class_name => 'Transit::Context'
    end
    
    def timestamp
      return "" if self.post_date.nil?
      self.post_date.strftime("%B %d, %Y")
    end
  
  end
end