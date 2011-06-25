module Transit
  module Builders
    class PackageBuilder
      
      attr_accessor :form, :resource, :template
      
      def initialize(model, form_builder)
        @form     = form_builder
        @resource = model
        @template = @form.template
      end
      
      def body
        
      end
      
      private
      
      def _create_field_for(method)
        form_method = _lookup_proper_field(method)
        args =[method]        
        if form_method.is_a?(Hash)
          args << form_method[form_method.keys.first]
          form_method = form_method.keys.first
        end        
        form.send(form_method, *args)
      end
      
      def _lookup_proper_field(method)
        resource.admin_options.fields[method]
      end
      
      def method_missing(*args)
        instance_eval <<-METHOD, __FILE__, __LINE__ + 1
          def #{args.first}
            _create_field_for(:#{args.first})
          end
        METHOD
        _create_field_for(args.first.to_sym)
      end
      
    end
       
  end
end