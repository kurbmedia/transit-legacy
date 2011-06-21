module Transit
  module Post
    module Fields
      extend ActiveSupport::Concern
      
      included do
        field :title,           :type => String
        field :post_date,       :type => Date
        field :slug,            :type => String,  :default => nil
        field :teaser,          :type => String
        field :default_teaser,  :type => String,  :default => ''
        field :published,       :type => Boolean, :default => false

        field :display_image, :type => Boolean, :default => true
        
        scope :published, where(:published => true, :post_date.lte => Date.today)
        before_validation :make_slugged_title, :if => lambda{ |p| p.published? }
        before_save :make_slugged_title, :if => lambda{ |p| p.published? }
        after_save :set_default_teaser
        
      end
      
      def make_slugged_title
        return true unless self.published?
        return true unless self.slug.to_s.blank?
        self.slug = self.title.to_slug
      end
      
      def set_default_teaser
        return true unless self.default_teaser.blank?
        textfield = self.contexts.ascending(:position).detect{ |c| c._type.to_s == 'Text' }
        return true unless textfield      
        doc = ::Nokogiri::HTML::DocumentFragment.parse(textfield.body)
        self.update_attribute(:default_teaser, doc.xpath('.//p').first.try(:text).to_s)
      end
      
    end
  end
end