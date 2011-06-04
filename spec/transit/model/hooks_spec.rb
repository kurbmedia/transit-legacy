require 'spec_helper'

describe 'model hooks' do
  
  subject{ Post }
  its(:methods){ should include(:deliver_as) }
  its(:methods){ should include(:deliver_with) }
  
  describe 'adding attachments' do
    
    before{ Post.send(:deliver_with, :attachments) }
    its(:included_modules){ should include(Transit::Model::Attachments) }
  end
  
  describe 'adding comments' do
    
    before{ Post.send(:deliver_with, :comments) }
    its(:included_modules){ should include(Transit::Model::Comments) }
  end

  
end