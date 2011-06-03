module Transit
  module Post
    module Fields
      extend ActiveSupport::Concern
      
      included do
        field :title,       :type => String
        field :post_date,   :type => Date
        field :slug,        :type => String,  :default => nil
        field :teaser,      :type => String
        field :published,   :type => Boolean, :default => false
        
        scope :published, where(:published => true, :post_date.lte => Date.today)
        before_validation :make_slugged_title, :if => lambda{ |p| p.published? }
        before_save :make_slugged_title, :if => lambda{ |p| p.published? }
      end
      
      def make_slugged_title
        return true unless self.published?
        return true unless self.slug.to_s.blank?
        self.slug = self.title.to_slug
      end
      
    end
  end
end