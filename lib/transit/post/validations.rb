module Transit
  module Post
    module Validations
      extend ActiveSupport::Concern
      
      included do
        validates :title, presence: true
        validates :slug, presence: { if: lambda{ |p| p.published? }, allow_blank: false }
        validates :slug, uniqueness: { if: lambda{ |p| p.published? }, scope: :_type, message: "A post already exists with this exact title." }
      end
      
    end
  end
end