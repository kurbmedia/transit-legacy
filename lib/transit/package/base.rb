module Transit
  module Package
    
    module Base
      extend ActiveSupport::Concern
      
      included do
        include Mongoid::Timestamps
        include Mongoid::MultiParameterAttributes
        
        field :uid,         :type => Integer
        field :published,   :type => Boolean, :default => false
        
        before_create :generate_uid
        
        embeds_many :contexts, as: :package, class_name: 'Transit::Context'
        accepts_nested_attributes_for :contexts, :allow_destroy => true
        alias :contexts_attributes= :process_context_attributes=
        scope :published, where(:published => true)
      end
      
      def generate_uid
        return true unless self.uid.nil?        
        ref = self.class.collection.name.singularize.classify.constantize
        self.uid = ref.max(:uid).to_i + 1
      end
      
      def process_context_attributes=(hash)
        hash.each_pair do |pos, attrs|
          attrs.stringify_keys!
          field = self.contexts.all.detect{ |cf| cf.id.to_s == attrs['id'] } || self.contexts.build({ }, attrs['_type'].classify.constantize)
          field.attributes = attrs
        end
      end
      
      def timestamp
        return "" if self.post_date.nil?
        self.post_date.strftime("%B %d, %Y")
      end
      
    end
    
  end
end