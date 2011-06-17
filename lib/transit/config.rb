module Transit
  module Config
   
    mattr_accessor :assets
    @@assets ||= {
      styles: {
        full:     "475x>",
        thumb:    "50x50#",
        small:    "100x100#",
        medium:   "300x>",
        original: "1500x1500>"
      },
      
      default_style: :full,
      path: ":rails_root/public/system/assets/:uid/:style.:extension",
      url:  "/system/assets/:uid/:style.:extension"
    }
    
  end
end