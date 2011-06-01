module Transit
  module Posts
    module Validations
      extend ActiveSupport::Concern
      
      included do
        validates :title, :presence   => true
        validates :slug,  :presence   => { :allow_blank => false }, 
                          :uniqueness => { :scope => :_type, :message => "A post already exists with this exact title." }
      end
      
    end
  end
end