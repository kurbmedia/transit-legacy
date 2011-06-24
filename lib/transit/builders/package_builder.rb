module Transit
  module Builders
    class PackageBuilder
      instance_methods.each{ |m| undef_method m unless m =~ /^(__|object_id)/ }
      
      attr_accessor :form, :resource, :template
      
      def initialize(res, frm, tpl)
        @template = tpl
        @form     = frm
        @resource = res
      end
      
      def method_missing(method, *args)
        resource.send(:"#{method}")
      end
      
    end
       
  end
end