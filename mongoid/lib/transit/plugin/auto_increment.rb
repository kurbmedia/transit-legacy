module Transit
  module Plugin
    ##
    # Provides SQL style auto_incremeing id's to Mongo documents
    # 
    module AutoIncrement
      
      def auto_increment
        include Macros
      end
      
      module Macros        
        def self.included(doc)
          doc.send(:field, :uid, type: Integer)
          doc.send(:before_create, :generate_uid, on: :create)
        end
        def generate_uid
          return true unless self.uid.nil?        
          ref = (self.class.superclass == Object ? self.class : self.class.superclass)
          self.uid = ref.max(:uid).to_i + 1
        end
      end
      
    end
  end
end

Transit.on_definition(:post) do
  plugin :auto_increment
end

Transit.on_definition(:page) do
  plugin :auto_increment
end