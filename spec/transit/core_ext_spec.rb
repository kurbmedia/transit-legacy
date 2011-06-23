require 'spec_helper'

describe 'core extensions' do
  require 'transit/core_ext'
  
  specify{ String.new.respond_to?(:to_slug).should be_true }
  
  
end