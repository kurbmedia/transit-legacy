module Transit
  module Post
    
    autoload :Lookups,      'transit/post/lookups'
    autoload :Fields,       'transit/post/fields'
    autoload :Validations,  'transit/post/validations'
    
    extend ActiveSupport::Concern
    
    included do      
      include Transit::Model::Base      
      include Transit::Post::Fields
      include Transit::Post::Lookups
      include Transit::Post::Validations      
    end
    
    def timestamp
      return "" if self.post_date.nil?
      self.post_date.strftime("%B %d, %Y")
    end
    
    def teaser
      return self.attributes['teaser'] unless self.attributes['teaser'].to_s.blank?
      return @teaser_text if @teaser_text 
      textfield = self.contexts.ascending(:position).detect{ |c| c._type.to_s == 'Text' }
      return "" unless textfield      
      doc = ::Nokogiri::HTML::DocumentFragment.parse(textfield.body)
      @teaser_text = doc.xpath('.//p').first.try(:text).to_s
    end
    
  end
end