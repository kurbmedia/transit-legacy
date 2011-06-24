module Transit
  ##
  # Manages configuration options for models.
  # When a model is managed via the admin, register it by Transit::Admin.register and 
  # passing a configuration block.
  # 
  # @example Assign the columns to be displayed on "index"
  #   Transit::Admin.register :model_name do |config|
  #     config.columns = [:name, :title]
  #   end
  # 
  module Admin
    
    def self.register(klass, &block)
      klass = klass.to_s.classify.constantize
      unless klass.respond_to?(:admin_options)
        klass.send(:class_attribute, :admin_options, instance_writer: false)
      end
      dsl = klass.admin_options ||= DSL.new
      block.call(dsl)
      klass.admin_options = dsl
    end
    
    class DSL
      
      attr_accessor :columns, :column_hash
      
      ##
      # Specify the columns to be displayed in the admin. At minimum the name of a 
      # method is required. For additional options, use hash syntax.
      # 
      # @example List a title and post_date column
      #   config.columns :title, :post_date
      # 
      # @example List a title field, and a post_date field, where post_date uses a proc to describe its value. When called
      # the proc will be passed a reference to the current object.
      # 
      #   config.columns :title, post_date: lambda{ |obj| obj.created_at.to_formatted_s }
      # 
      # @example Overriding the displayed name
      #   
      #   config.columns :title, timestamp: { as: 'Post Date' }
      # 
      def columns(*cols)
        options = cols.extract_options!
        @column_hash = ActiveSupport::OrderedHash.new
        cols.each.each do |col|
          @column_hash[col] = col.to_s.titleize
        end
        options.each do |name, value|
          @column_hash[name] = case value
          when Proc then [name.to_s.titleize, value]
          when Hash
            colname = (value[:as].present? ? value[:as].to_s.titleize : name.to_s.titleize)
            (value[:proc].present? ? [colname, value[:proc]] : colname)
          end
        end
      end
      
    end
    
  end
end