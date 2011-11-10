module Transit
  class Context
  
    def media_context?
      false
    end
    
    # Sets up an "identifier" for the particular context
    def shortname
      self.class.to_s.underscore
    end

    # Sets up a default name field to be used in form helpers
    def field_name
      self.class.to_s
    end
    
  end
end