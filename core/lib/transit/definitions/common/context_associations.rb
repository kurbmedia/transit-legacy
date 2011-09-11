module Transit
  module Definition
    module Common
      
      ##
      # Contexts may be related to definitions in different ways depending on ORM.
      # When using Mongo for example, contexts are better embedded than related. 
      # ORM's should override this method to create the association properly.
      # 
      module ContextAssociations
        def create_context_association
          raise NotImplementedError
        end
      end
      
    end
  end
end