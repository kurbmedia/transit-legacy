module Transit
  class Post
    include Mongoid::Document
    include Mongoid::Timestamps
    include Mongoid::MultiParameterAttributes
    include Transit::Posts
    include Paperclip::Glue
    
    store_in :posts
    has_many :comments, :as => :commentable
    references_and_referenced_in_many :topics
    has_and_belongs_to_many :assets, :class_name => 'Transit::Asset', :dependent => :destroy
    
    before_create :ensure_text_context
    
    field :image_file_name,     :type => String
    field :image_content_type,  :type => String
    field :image_file_size,     :type => Integer
    field :image_updated_at,    :type => Time
    field :display_image,       :type => Boolean, :default => true
    field :comment_count,       :type => Integer

    field :published, :type => Boolean, :default => false
    modded_with :sluggable, :fields => :title, :as => :slug
   
    has_attached_file :image,
       :styles => {
         :full      => "630x>",
         :medium    => "540x300#",
         :thumb     => "150x150#",
         :original  => "1500x1500>"
       },
       :path => ":rails_root/public/system/post_images/:uid/:style.:extension",
       :url  => "/system/post_images/:uid/:style.:extension",
       :default_style => :full
       
    def default_image
      return nil unless self.image.file?
      self.image.url(:thumb)
    end
    
    def has_comments?
      comment_count.to_i >= 1
    end
    
    def ensure_text_context
      return true unless self.contexts.count == 0
      self.contexts.build({ :name => 'Body Copy' }, Text)
    end
    
  end
end