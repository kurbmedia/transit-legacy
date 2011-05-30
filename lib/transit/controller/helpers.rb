module Transit
  module Controller
    module Helpers
      extend ActiveSupport::Concern
      
      included do
        helper_method :scope_name, :scope_class, :resource, :collection
      end

      def scope_name
        (action_name.to_s === 'index' ? scope_class.to_s.pluralize : scope_class.to_s).underscore
      end

      def scope_class
        return @_scope_class unless @_scope_class.nil?        
        @_scope_class = self.class.to_s.split("::").last.gsub(/controller/i, '').singularize.constantize
      end
      
      def collection
        [get_instance_var].flatten
      end
      
      def resource
        get_instance_var
      end

      private

      def get_instance_var
        instance_variable_get("@#{scope_name}")
      end

      def set_instance_var(obj)
        instance_variable_set("@#{scope_name}", obj)
      end
      
    end
  end
end