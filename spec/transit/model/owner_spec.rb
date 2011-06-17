require 'spec_helper'

describe 'Owner' do
  
  subject{ Post }
  
  context 'when not assigned to a user' do
    
    it{ should_not belong_to(:user) }
    specify{ User.should_not have_many(:posts) }
    specify{ Post.new.delivers?(:owner).should be_false }
  end
  context 'when assigned to a user' do
    
    before(:all){ Post.send(:deliver_with, :owner) }
    it{ should belong_to(:user) }
    specify{ User.should have_many(:posts) }
    specify{ Post.new.delivers?(:owner).should be_true }
  end
  
end