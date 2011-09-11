require 'transit/definitions/page/metadata'
require 'transit/definitions/page/attributes'

module Transit
  module Definition
    module Page
      include Transit::Definition::Common
      include Metadata
      include Attributes
      extend ActiveSupport::Concern
      
      included do
      end
      
    end    
  end
end