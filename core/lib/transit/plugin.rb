module Transit
  ##
  # Plugin support. Allows adding any plugin to a package. 
  # Inspired by MongoMapper's awesome plugin implementation
  # 
  module Plugin    
    include ActiveSupport::DescendantsTracker
    
    autoload :Assets,      'transit/plugin/assets'
    autoload :Attachments, 'transit/plugin/attachments'
    autoload :Comments,    'transit/plugin/comments'
    autoload :Ownership,   'transit/plugin/ownership'
    autoload :Topics,      'transit/plugin/topics' 
    
    def plugins
      @plugins ||= []
    end
    
    def plugin(*options)
      options.map(&:to_s).map(&:camelize).each do |mod|
        begin
          include Transit::Plugin.const_get(mod)
        rescue LoadError
          raise Transit::Errors::PluginMissing.new("Could not load the plugin, '#{mod}'")
        end
        direct_descendants.each{ |model| model.send(:include, mod) }
      end
      plugins |= options
    end    
    alias :deliver_with :plugin
    
    def included(base = nil, &block)
      direct_descendants << base if base
      super
    end
    
    ##
    # Support registering plugins from other engines, internal or external.
    # @param plugin [String,Symbol] The name of the plugin to load
    # @param path [String] The path where autoload should look for the plugin
    # 
    def self.register(plugin, path = nil)
      path ||= "transit/plugin/assets/#{plugin.to_s.underscore}"
      self.send :autoload, plugin, path
    end

  end
end
