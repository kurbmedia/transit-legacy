module Transit
  module Model
    ##
    # Provides SQL like auto-incrementing of an id using a "uid" field
    # 
    module AutoIncrement
      extend ActiveSupport::Concern
      
      included do
        field :uid, :type => Integer
        before_create :generate_uid, :on => :create
      end
      
      def generate_uid
        return true unless self.uid.nil?        
        ref = (self.class.superclass == Object ? self.class : self.superclass)
        self.uid = ref.max(:uid).to_i + 1
      end
      
    end
  end
end