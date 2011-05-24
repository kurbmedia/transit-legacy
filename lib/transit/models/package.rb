module Transit
  module Models
    module Package
      extend ActiveSupport::Concern
      
      included do
        class_attribute :transit_contexts, :instance_writer => false
        self.transit_contexts ||= []
        
        field :title,       :type => String
        field :post_date,   :type => Time
        field :published,   :type => Boolean, :default => false
        field :slug,        :type => String
        field :intro_body,  :type => String
        field :uid,         :type => Integer
                
        modded_with :sluggable, :fields => :title, :as => :slug
        
        before_create :generate_uid        
      end
      
      def generate_uid
        return true unless self.uid.nil?        
        ref = self.class.collection.name.singularize.classify.constantize
        self.uid = ref.max(:uid).to_i + 1
      end
      
      def timestamp
        return "" if self.post_date.nil?
        self.post_date.strftime("%B %d, %Y")
      end
      
    end
  end
end