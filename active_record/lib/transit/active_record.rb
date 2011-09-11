require 'active_record'
require 'transit/definition'

ActiveRecord::Base.send(:include, Transit::Definition::Hook)

require 'transit/active_record/definition'
require 'transit/active_record/context_associations'
require 'transit/active_record/models'