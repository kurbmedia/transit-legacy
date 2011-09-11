require 'mongoid'
require 'transit/definition'

Mongoid::Document::ClassMethods.class_eval do
  include Transit::Definition::Hook
end

require 'transit/mongoid/definition'
require 'transit/mongoid/context_associations'
require 'transit/mongoid/models'
require 'transit/plugin/auto_increment'