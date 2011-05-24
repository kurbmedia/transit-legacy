module Transit
  module Models
    module Context
      extend ActiveSupport::Concern
      
      included do
        class_attribute :transit_model_type, :instance_writer => false
        self.transit_model_type ||= :context
        
        include Mongoid::Document
        
        field :name,      :type => String
        field :meta,      :type => Hash, :default => {}
        field :body,      :type => String
        field :position,  :type => Integer
        
        before_save :ensure_context_position_value
        embedded_in :contextable, polymorphic: true        
      end
      
      def ensure_context_position_value
        return true unless self.position.nil?
        self.position = _parent.send(:contexts).count + 1
      end

      # Sets up an "identifier" for the particular context
      def shortname
        self.class.to_s.underscore
      end

      # Sets up a default name field to be used in form helpers
      def field_name
        (self.name.to_s.blank? ? self.class.to_s : self.name)
      end
      
    end
  end
end