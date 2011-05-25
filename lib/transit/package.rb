module Transit
  module Package
    autoload :Base,   'transit/package/base'
    autoload :Post,   'transit/package/post'
    autoload :Page,   'transit/package/page'
    
    module Hook
      def transit(template, options = {})
        include Transit::Package::Base
        include Transit::Package.const_get(template.to_s.classify)        
      end
    end
  end
end


Mongoid::Document::ClassMethods.class_eval do
  include Transit::Package::Hook
end