module Transit
  class Package
    def self.inherited(base)
      base.send(:include, Transit::Models::Package)
      base.class_eval do
        include Mongoid::Timestamps
        if self.superclass.to_s == "Transit::Package"
          store_in :"#{base.name.pluralize.underscore}"
        end
      end      
    end
      
  end
end