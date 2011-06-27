module Transit
  module Services
    ##
    # Provides access for reading twitter streams/feeds. 
    # For posting and publishing, auth tokens are required.
    # 
    class Twitter < Base
      attr_accessor :auth_token
      
    end
    
  end
end