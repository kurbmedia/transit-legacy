require 'spec_helper'

describe 'model attachments' do
  
  subject{ Post }
  before(:all){ Post.send(:delivers, :assets) }

  it 'creates an association to assets' do
    Post.new.respond_to?(:assets).should be_true
  end

  
end