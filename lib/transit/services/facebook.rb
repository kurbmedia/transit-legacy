module Transit
  module Services
    ##
    # Provides access for reading facebook streams/feeds. 
    # For posting and publishing, auth tokens are required.
    # 
    class Facebook < Base
      attr_accessor :auth_token
      
    end
    
  end
end