require 'active_support'
require 'transit/core_ext'

module Transit
  
  autoload :Admin, 'transit/admin'
  autoload :Config, 'transit/config'
  
  module Package
    autoload :Post, 'transit/package/post'
    autoload :Page, 'transit/package/page'
  end
  
  module Model
    autoload :Assets,        'transit/model/assets'
    autoload :Attachments,   'transit/model/attachments'
    autoload :AutoIncrement, 'transit/model/auto_increment'
    autoload :Comments,      'transit/model/comments'
    autoload :Topics,        'transit/model/topics'
    autoload :Base,          'transit/model/base'
    autoload :Hooks,         'transit/model/hooks'
    autoload :Owners,        'transit/model/owners'
    autoload :Paginator,     'transit/model/paginator'
  end
  
  module Controller
    autoload :Generator,  'transit/controller/generator'
    autoload :Responder,  'transit/controller/responder'
  end
  
  module Errors
    autoload :InvalidContext,   'transit/errors/invalid_context'
    autoload :ResourceNotFound, 'transit/errors/resource_not_found'
  end
  
  module Builders
    autoload :JstBuilder,      'transit/builders/jst_builder'
    autoload :FormBuilder,     'transit/builders/form_builder'
    autoload :PackageBuilder,  'transit/builders/package_builder'
  end
    
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
require 'transit/model/hooks'
require 'transit/rails/engine'