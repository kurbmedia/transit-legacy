module Transit
  module Posts    
    
    autoload :Lookups,      'transit/posts/lookups'
    autoload :Fields,       'transit/posts/fields'
    autoload :Validations,  'transit/posts/validations'
    
    extend ActiveSupport::Concern
    
    included do
      include Transit::Model::Helpers
      include Transit::Posts::Fields
      include Transit::Posts::Lookups
      include Transit::Posts::Validations        
      scope :published, where(:published => true, :post_date.lte => Date.today)
    end
    
    def timestamp
      return "" if self.post_date.nil?
      self.post_date.strftime("%B %d, %Y")
    end
    
    def teaser
      return self.attributes['teaser'] unless self.attributes['teaser'].to_s.blank?
      textfield = self.contexts.ascending(:position).detect{ |c| c._type.to_s == 'Text' }
      return "" unless textfield
      return @teaser_text if @teaser_text 
      doc = Nokogiri::HTML::DocumentFragment.parse(textfield.body)
      @teaser_text = doc.xpath('.//p').first.try(:text).to_s
    end
    
  end
end