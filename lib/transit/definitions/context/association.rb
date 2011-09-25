module Transit::Definition
  module Context
    ##
    # Association methods and functionality which 
    # any model with contexts should utilize
    # 
    module Association
      extend ActiveSupport::Concern
      
      included do
        accepts_nested_attributes_for :contexts, :allow_destroy => true
        alias :contexts_attributes= :build_context_attributes=
      end
      
      def build_context_attributes=(hash)
        hash.each_pair do |position, attrs|
          attrs.stringify_keys!
          next if attrs.empty?
          field = self.contexts.detect do |con| 
            con.id.to_s === attrs['id'].to_s
          end
          field ||= self.build_context_by_specified_type(attrs)
          field.attributes = attrs
        end
      end
      
      private
      
      def build_context_by_specified_type(attrs)
        sti_name = self.class.inheritance_column.to_s
        sti_type = attrs.delete(sti_name)
        field = self.build_context(attrs)
        field.write_attribute(sti_name, sti_type)
        field = field.becomes(sti_type.classify.constantize) if field.respond_to?(:becomes)
        field
      end
      
    end
  end
end