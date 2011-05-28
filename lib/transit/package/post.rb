module Transit
  module Package
    
    module Post
      extend ActiveSupport::Concern
      
      included do
        
        field :title,       :type => String
        field :post_date,   :type => Date
        field :slug,        :type => String
        field :teaser,      :type => String
        
        validates :title, :presence   => true
        validates :slug,  :presence   => { :allow_blank => false }, 
                          :uniqueness => { :scope => :_type, :message => "A post already exists with this exact title." }
        
        scope :published, where(:published => true, :post_date.lte => Date.today)
        modded_with :sluggable, :fields => :title, :as => :slug
        alias :timestamp_method :post_date               
      end
      
      # Grab the previous post for a previous > next link list
      #
      def previous_post
        @previous_post ||= self.class.only(:title, :slug).where(:post_date.lt => self.post_date).descending(:post_date).first
      end

      # Grab the next post for a previous > next link list
      #
      def next_post
        @next_post ||= self.class.only(:title, :slug).where(:post_date.gt => self.post_date).ascending(:post_date).first
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
end