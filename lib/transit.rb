require 'active_support'

module Transit
    
  DESCRIPTIONS = {}
  
  # Store an array of controller mappings
  mattr_accessor :mappings
  @@mappings = []

  def self.add_mapping(obj)
    @@mappings << obj
  end

  def self.configure(&block)
    yield Transit::Config
  end

  def self.contexts
    ["Text","Video", "Audio"]
  end
  
  def self.track(klass, template)
    DESCRIPTIONS[template] ||= []
    DESCRIPTIONS[template] |= [klass.to_s]
  end
  
  def self.lookup(template)
    DESCRIPTIONS[template] ||= []
  end
  
  def self.superclass_for(template)
    DESCRIPTIONS[template].detect do |klass|
      klass.constantize.superclass === Object
    end
  end
  
end

require 'transit-core'