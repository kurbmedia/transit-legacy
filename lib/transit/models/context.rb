module Transit
  module Models
    module Context
      extend ActiveSupport::Concern
      
      included do
        class_attribute :transit_packages, :instance_writer => false
        self.transit_packages ||= []
        
        field :name, :type => String
        field :meta, :type => Hash, :default => {}
        field :body, :type => Text
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