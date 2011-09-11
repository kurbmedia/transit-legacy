require 'transit/extensions/string'

module Transit
  module Plugin
    module Slugable      
      extend ActiveSupport::Concern      
      included do
        before_save :generate_slug
      end     
    end
  end
end