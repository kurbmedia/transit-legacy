module Transit
  class Post
    include Mongoid::Document
    include Mongoid::Timestamps
    include Mongoid::MultiParameterAttributes
    include Transit::Posts
    include Paperclip::Glue
    
    store_in :posts
    
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
   
    
  end
end