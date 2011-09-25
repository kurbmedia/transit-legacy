module Transit
  class Context
    deliver_as :context    

    def media_context?
      false
    end
    
  end
end