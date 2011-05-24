module Transit
  module Models
    
    module Package
      extend ActiveSupport::Concern
      
      included do        
        include Mongoid::Document
        include Mongoid::Timestamps
        include Mongoid::MultiParameterAttributes
        
        field :title,       :type => String
        field :post_date,   :type => Time
        field :published,   :type => Boolean, :default => false
        field :slug,        :type => String
        field :intro_body,  :type => String
        field :uid,         :type => Integer

        modded_with :sluggable, :fields => :title, :as => :slug        
        embeds_many :contexts, :as => :contextable, :class_name => "Transit::Context"
        accepts_nested_attributes_for :contexts, :allow_destroy => true
        alias :contexts_attributes= :process_context_attributes=
        
        before_create :generate_uid        
        scope :published, where(:published => true)
      end
      
      def process_context_attributes=(hash)
        hash.each_pair do |pos, attrs|
          attrs.stringify_keys!
          field = self.contexts.all.detect{ |cf| cf.id.to_s == attrs['id'] } || self.contexts.build({ }, attrs['_type'].classify.constantize)
          field.attributes = attrs
        end
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
      
      module ClassMethods
        def transit_package?
          true
        end
      end
      
    end
    
  end
end