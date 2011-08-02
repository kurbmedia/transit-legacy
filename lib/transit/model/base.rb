module Transit
  module Model
    
    module Base
      extend ActiveSupport::Concern
      
      included do
        class_attribute :delivery_options, instance_writer: false
        self.delivery_options ||= []
        
        class_attribute :admin_options, instance_writer: false
        
        include Mongoid::Timestamps
        include Mongoid::MultiParameterAttributes
        include Transit::Model::AutoIncrement
                
        # All transit models embed many contexts
        embeds_many :contexts, as: :package, class_name: 'Transit::Context'        
        accepts_nested_attributes_for :contexts, allow_destroy: true
        alias :contexts_attributes= :process_context_attributes=        
        before_create :ensure_text_context
        
      end
      
      def context_named(n)
        self.contexts.by_name(n).first
      end
      
      ##
      # Convenience method to determine the particular options this
      # model delivers
      # 
      def delivers?(opt)
        self.class.delivery_options.include?(opt.to_s)
      end
      
      ##
      # Each model should pre-build at least one context for its main body content
      # 
      def ensure_text_context
        return true unless self.contexts.size == 0
        self.contexts.build({ :name => 'Body Copy' }, Text)
      end
      
      def process_context_attributes=(hash)
        hash.each_pair do |pos, attrs|
          attrs.stringify_keys!
          field = self.contexts.all.detect{ |cf| cf.id.to_s == attrs['id'] } || self.contexts.build({ }, attrs['_type'].classify.constantize)
          field.attributes = attrs
        end
      end
    
    end
    
  end
end