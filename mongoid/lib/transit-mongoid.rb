module Transit
  module Mongoid
    VERSION = '0.0.2'
  end
end

require 'mongoid'
require 'transit/mongoid/bindings'
require 'transit/mongoid/auto_increment'
require 'transit/package'
require 'transit/plugin'
require 'transit/plugin/paginator'

Mongoid::Document::ClassMethods.class_eval do
  include Transit::Package::Hook
  include Transit::Plugin
  include Transit::Mongoid::Bindings
  include Transit::Mongoid::AutoIncrement
  include Transit::Plugin::Paginator::ClassMethods
end

Mongoid::Criteria.send :include, Transit::Plugin::Paginator::Criteria
Mongoid::Document.send :include, Transit::Plugin::Paginator::Document