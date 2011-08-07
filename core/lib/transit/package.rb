module Transit
  module Package
    
    autoload :Post, 'transit/package/post'
    autoload :Page, 'transit/package/page'
    
    module Hook
      def deliver_as(type)
        scope = type.to_s.classify
        include Transit::Package.const_get(scope)
        Transit.track(self, type.to_sym)
      end
    end
    
  end
end