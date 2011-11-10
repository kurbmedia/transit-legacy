module Transit
  module Plugin
    ##
    # Provides SQL style auto_incremeing id's to MongoDB documents
    # 
    module AutoIncrement
      def auto_increment(fname = :uid)
        field fname, :type => Integer
        include Macros
      end
      
      module Macros        
        extend ActiveSupport::Concern
        
        included do
          before_create :generate_uid
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