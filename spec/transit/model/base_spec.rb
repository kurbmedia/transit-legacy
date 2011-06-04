require 'spec_helper'

describe 'base models' do
  
  describe 'any type' do
    
    subject{ Post }
    specify{ Post.respond_to?(:delivery_options).should be_true }
    
    describe 'an instance' do
      
      before(:all){ Post.send(:deliver_with, :attachments) }
      subject{ Post.new }
      its(:methods){ should include(:delivers?) }
      specify{ subject.delivers?(:attachments).should be_true }
    end
  end
  
  describe 'Post types' do
  
    subject{ Post }
    it{ should embed_many(:contexts) }    
  end
  
  describe 'Page types' do
  
    subject{ Page }
    it{ should embed_many(:contexts) }    
  end
  
end