require 'transit/definitions/page/attributes'

module Transit
  module Definition    
    module Post   
      include Transit::Definition::Common
      include Attributes
      extend ActiveSupport::Concern      
      
      included do
      end
      
    end
  end
end