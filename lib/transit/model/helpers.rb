module Transit
  module Model
    ##
    # Global methods for all package based models.
    # 
    module Helpers
      extend ActiveSupport::Concern
      
      included do
        field :uid,       :type => Integer
        field :published, :type => Boolean, :default => false
        
        # Increment the sql_id each time to have a sql (auto_increment) style id for each post.
        before_create :generate_uid, :on => :create        
        embeds_many :contexts, as: :package, autosave: true, class_name: 'Transit::Context'
        
        accepts_nested_attributes_for :contexts, :allow_destroy => true
        alias :contexts_attributes= :process_context_attributes=
      end
      
      def context_named(n)
        self.contexts.by_name(n).first
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
        return "" if self.created_at.nil?
        self.created_at.strftime("%B %d, %Y")
      end
      
    end
  end
end