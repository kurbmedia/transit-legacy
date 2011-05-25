module Transit
  module Package
    
    module Base
      extend ActiveSupport::Concern
      
      included do
        class_attribute :transit_config, :instance_writer => false
        self.transit_config ||= {}
        
        include Mongoid::Timestamps
        include Mongoid::MultiParameterAttributes
        include Transit::Helpers::ModelHelpers
        
        field :published, :type => Boolean, :default => false
      
        embeds_many :contexts, as: :package, class_name: 'Transit::Context'
        accepts_nested_attributes_for :contexts, :allow_destroy => true
        alias :contexts_attributes= :process_context_attributes=        
      end
      
      def process_context_attributes=(hash)
        hash.each_pair do |pos, attrs|
          attrs.stringify_keys!
          field = self.contexts.all.detect{ |cf| cf.id.to_s == attrs['id'] } || self.contexts.build({ }, attrs['_type'].classify.constantize)
          field.attributes = attrs
        end
      end
      
      module ClassMethods
        
        def configure_transit_package!
          if add_assets = self.transit_config[:assets]
            has_and_belongs_to_many :package_assets, as: :package if add_assets
          end
        end
        
      end
      
    end
    
  end
end