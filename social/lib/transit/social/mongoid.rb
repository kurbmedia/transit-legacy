require 'mongoid'

class Comment
  include ::Mongoid::Document
  include ::Mongoid::Timestamps
  deliver_as :comment
end
