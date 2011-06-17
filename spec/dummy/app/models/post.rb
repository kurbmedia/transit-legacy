class Post
  include Mongoid::Document
  deliver_as :post
  deliver_with :attachments, :topics, :comments, :assets
  
  attach :image, 
    styles: {
      full:     '630x>',
      medium:   '540x300#',
      thumb:    '150x150#'
    },
    path: ":rails_root/public/system/post_images/:uid/:style.:extension",
    url:  "/system/post_images/:uid/:style.:extension",
    default_style:  :full
  
end