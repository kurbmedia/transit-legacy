module Transit
  module Definition
    module Page
      ##
      # Defines page metadata (ie: html meta tags). 
      # A page definition assumes certain variables always exist on every page. These include:
      #   
      #   title
      #   url
      #   description
      #   keywords
      # 
      module Metadata
        ##
        # Keywords may be added via string or array, this provides 
        # more flexibility when implementing admin interfaces.
        # 
        def keywords=(kw)
          to_write = case kw
          when Array then kw.join(", ")
          when Hash then kw.to_a.join(", ")
          else kw
          end
          
          write_attribute("keywords", to_write)          
        end
        
        ##
        # Since mongo based models support array functionality, 
        # keywords may also be stored as an array. This method 
        # simply normalizes output into a string.
        # 
        # @param [Boolean] raw Passing true will return the raw database attribute.
        # 
        # 
        def keywords(raw = false)
          raw_attr = read_attribute('keywords')
          return raw_attr if raw
          
          case raw_attr
          when Array then raw_atr.join(", ")
          when Hash then raw_attr.to_a.join(", ")
          else raw_attr
          end
        end
        
      end
      
    end
  end
end