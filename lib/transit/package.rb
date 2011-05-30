module Transit
  module Package
    autoload :Base,   'transit/package/base'
    autoload :Post,   'transit/package/post'
    autoload :Page,   'transit/package/page'
    
    module Hook
      def transit(template, options = {})
        
        include Transit::Package::Base
        self.transit_config.merge!(options.merge( :template => template ))
        configure_transit_package!
        
        # Apply a particular package template to the model
        # and track its existance
        include Transit::Package.const_get(template.to_s.classify)
        Transit.track(self, template.to_sym)        
      end
    end
  end
end


Mongoid::Document::ClassMethods.class_eval do
  include Transit::Package::Hook
end