module Transit
  module AdminHelper
    
    def admin_table_heading(header)
      th = case header
      when String || Symbol
        header
      when Hash then header.keys.first
      when Array then header.first
      else header
      end
      th.to_s.titleize
    end
    
    def admin_table_cell(item, name)
      return item.send(name) if name.is_a?(String) or name.is_a?(Symbol)
      if name.is_a?(Hash)
        method = name.values.first
        if method.is_a?(Proc) or method.respond_to?(call)
          return method.call(item)
        end
        return item.send(method)
      end
    end
    
  end
end