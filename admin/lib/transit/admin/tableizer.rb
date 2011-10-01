module Transit
  module Admin
    module Tableizer
      def admin_attributes(*args)
        include TableAttributes
        return self.admin_attribute_names if args.empty?
        self.admin_attribute_names |= args
      end
      
      module TableAttributes
        extend ::ActiveSupport::Concern
        included do
          class_attribute :admin_attribute_names, :instance_reader => true
          self.admin_attribute_names ||= []
        end
      end
      
    end
  end
end