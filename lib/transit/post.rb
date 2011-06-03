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
      
      Transit.track(self, :post)
      
      # Slugify the title field... always
      modded_with :sluggable, fields: :title, as: :slug      
    end
    
  end
end