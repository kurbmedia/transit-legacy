module Transit
  module Definition
    module Common
      module ContextAssociations
        def create_context_association
          has_many :contexts, :as => :package, :class_name => "Transit::Context"
        end
      end
    end
  end
end