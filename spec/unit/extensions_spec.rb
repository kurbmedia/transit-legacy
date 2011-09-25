require 'spec_helper'

describe 'core extensions' do
  require 'transit/extensions/string'
  
  describe '.to_slug' do
    subject{ "Test title string" }
  
    specify do
      subject.respond_to?(:to_slug).should be_true
    end
  
    it 'creates a slug from a string' do
      subject.to_slug.should == 'test-title-string'
    end    
  end
  
  
end