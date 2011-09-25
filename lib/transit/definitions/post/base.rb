require 'transit/definitions/post/validations'
require 'transit/definitions/context/association'

module Transit::Definition
  ##
  # Post packages are generally used for blogs/news/articles etc. Posts are defined 
  # with a title, a post_date, a published state, and a "slug".
  # 
  # When delivering a model as a post, the following options are available:
  # 
  #   validate: If set to true, titles and post_dates will be validated
  #   slug_with: By default slugs are created from the "title" attribute. Pass a method name to override.
  # 
  # @example Deliver a model as a Post
  # 
  #   class MyPost
  #     deliver_as :post
  #   end
  # 
  # 
  # 
  module Post
    extend ActiveSupport::Concern
    
    included do
      include Transit::Definition::Context::Association
      create_context_association!
      delivery_options.post.reverse_merge!({
        :validate   => true,
        :slug_with  => :title
      })
            
      include Validations if delivery_options.post.validate === true        
      before_save :generate_post_slug, :if => lambda{ |p| p.published? }      
    end
    
    module ClassMethods        
      def published
        rel = where(:published => true)
        if :post_date.respond_to?(:lte)
          rel.where(:post_date.lte => Date.today)
        else
          rel.where("post_date <= ?", Date.today)
        end
      end        
    end
    
    def timestamp
      self.created_at.strftime("%B %d, %Y")
    end
    
    private
    
    def generate_post_slug
      return true unless self.slug.nil?
      self.slug = self.send(delivery_options.post.slug_with).to_s.to_slug
    end
      
  end
end

Transit::Schema.add(:post, {
  :title          => { :type => String },
  :post_date      => { :type => DateTime },
  :slug           => { :type => String },
  :teaser         => { :type => String },
  :default_teaser => { :type => String },
  :published      => { :type => Boolean, :default => false }
})