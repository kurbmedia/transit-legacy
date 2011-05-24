module ActionDispatch::Routing
  class Mapper
    ##
    # Calling transit within routes sets up routing for each 
    # model. By default all passed models are routed with:
    #   :controller => 'transit/packages
    #   :scope_name => 'ModelName'
    # 
    # Override these options when configuring if you would prefer a different controller/scope name
    # 
    def transit(*models)      
      options = models.extract_options!      
      models.map!(&:to_sym).each do |mod|
        sing   = ActiveSupport::Inflector.singularize(mod.to_s)
        plural = ActiveSupport::Inflector.pluralize(mod.to_s)
        resources *[plural, options.reverse_merge(:controller => 'transit/packages', :scope_name => "#{sing.classify}")]
      end
    end
    
  end
end