require 'spec_helper'

describe 'model attachments' do
  
  subject{ Post }
  before(:all){ Post.send(:delivers, :attachments) }

  it 'includes paperclip' do
    Post.included_modules.should include(Paperclip::Glue) 
  end
  
  it 'adds paperclip support' do
    Post.respond_to?(:has_attached_file).should be_true
  end
  
  it "adds an attach method" do
    Post.respond_to?(:attach).should be_true
  end
  
end