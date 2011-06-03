module Transit
  module Model
    
    module Base
      extend ActiveSupport::Concern
      
      included do
        include Mongoid::Timestamps
        include Mongoid::MultiParameterAttributes
        
        field :uid, :type => Integer
        # Increment the uid each time to have a sql (auto_increment) style id for each post.
        before_create :generate_uid, :on => :create
        # All transit models embed many contexts
        embeds_many :contexts, as: :package, autosave: true, class_name: 'Transit::Context'
        
        accepts_nested_attributes_for :contexts, :allow_destroy => true
        alias :contexts_attributes= :process_context_attributes=
        
        before_create :ensure_text_context
        
      end
      
      def context_named(n)
        self.contexts.by_name(n).first
      end
      
      ##
      # Each model should pre-build at least one context for its main body content
      # 
      def ensure_text_context
        return true unless self.contexts.count == 0
        self.contexts.build({ :name => 'Body Copy' }, Text)
      end
      
      def generate_uid
        return true unless self.uid.nil?        
        ref = (self.class.superclass.name.include?("Transit") ? self.class.superclass.name.singularize.classify.constantize : self.class)
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
      
      module ClassMethods
        ##
        # Convenience method for Paperclip's has_attached_file to ensure fields also exist.
        # 
        def attach(name, options)
          include Transit::Model::Attachments          
          has_attached_file name, options
          field :"#{name.to_s}_file_name",     :type => String
          field :"#{name.to_s}_content_type",  :type => String
          field :"#{name.to_s}_file_size",     :type => Integer
          field :"#{name.to_s}_updated_at",    :type => Time
          field :"#{name.to_s}_fingerprint",   :type => String
        end        
        def add_assets
          has_and_belongs_to_many :assets, as: :assetable, class_name: 'Transit::Asset', dependent: :destroy
        end        
        def add_comments
          has_many :comments, as: :commentable, dependent: :destroy
        end        
      end     
      
    end
    
  end
end