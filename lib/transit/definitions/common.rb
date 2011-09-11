require 'transit/definitions/common/context_associations'
require 'transit/definitions/common/publish_state'

module Transit
  module Definition
    ##
    # Defines common functionality used within both page and post models.
    # 
    module Common
      extend ActiveSupport::Concern
      
      included do
        include ContextAssociations
        include PublishState
      end      
    end
  end
end