module Transit
  class Context
    include Mongoid::Document
    
    field :name,      :type => String
    field :meta,      :type => Hash, :default => {}
    field :body,      :type => String
    field :position,  :type => Integer
    
    before_save :ensure_context_position_value
    embedded_in :package, polymorphic: true
    
    scope :by_name, lambda{ |n| where(:name => n) }
    
    def ensure_context_position_value
      return true unless self.position.nil?
      self.position = _parent.send(:contexts).count + 1
    end

    # Sets up an "identifier" for the particular context
    def shortname
      self.class.to_s.underscore
    end

    # Sets up a default name field to be used in form helpers
    def field_name
      (self.name.to_s.blank? ? self.class.to_s : self.name)
    end    
    
    def file_ext
      File.extname(self.body.to_s).sub('.', '')
    end
    
    def package_type
      (self.package.nil? ? "post" : self.package.class.name.to_s.underscore)
    end
    
    def to_js( attrs = {} )
      { 
        id: self.id.to_s,
        position: self.position.to_i, 
        package_id:   (self.package.nil? ? "" : self.package.id.to_s ),
        package_type: package_type,
        resource_url: package_type.pluralize,
      }.merge!( attrs )
    end
    
    def to_backbone( attrs = {} )
      ::Base64.encode64s(to_js(attrs).to_json)
    end
    
  end
end