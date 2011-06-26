module Transit::Package
  module Post
    
    autoload :Validations,  'transit/package/post/validations'
    
    extend ActiveSupport::Concern
    
    included do      
      class_attribute :delivery_template, instance_writer: false
      self.delivery_template = :post
      
      include Transit::Model::Base
      
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
      
      include Validations
      
    end
    
    # Grab the post "previous" to this one, ordered by post date
    # @example
    #   @post.previous_post
    # 
    def previous_post
      @previous_post ||= self.class.only(:title, :slug).where(:post_date.lt => self.post_date).descending(:post_date).first
    end

    # Grab the post "next" to this one, ordered by post date
    # @example
    #   @post.next_post
    #
    def next_post
      @next_post ||= self.class.only(:title, :slug).where(:post_date.gt => self.post_date).ascending(:post_date).first
    end
    
    # Returns a timestamp formatted to a normal "post date"
    # 
    def timestamp
      return "" if self.post_date.nil?
      self.post_date.strftime("%B %d, %Y")
    end
    
    # The "teaser" is a shortened version of a post used to display on "index" pages.
    # Post models include a "teaser" and a "default teaser" allowing teasers to be 
    # automatically generated from the first paragraph of the html body. It is assumed that 
    # all posts will include at least one Text context containing the body of the post
    # 
    def teaser
      return self.attributes['teaser'] unless self.attributes['teaser'].to_s.blank?
      default_teaser.to_s
    end
    
    private
    
    # Generate a URL-friendly slug from the title of this post
    # 
    def make_slugged_title
      return true unless self.published?
      return true unless self.slug.to_s.blank?
      self.slug = self.title.to_slug
    end
    
    # Generate the default teaser copy from the post's first html paragraph
    # 
    def set_default_teaser
      return true unless self.default_teaser.blank?
      textfield = self.contexts.ascending(:position).detect{ |c| c._type.to_s == 'Text' }
      return true unless textfield      
      doc = ::Nokogiri::HTML::DocumentFragment.parse(textfield.body)
      self.update_attribute(:default_teaser, doc.xpath('.//p').first.try(:text).to_s)
      doc = nil
      true
    end
    
  end
end