require 'spec_helper'

describe 'Ownership' do
  
  class User
    include Mongoid::Document
  end
  subject{ Post }
  
  context 'when not assigned to a user' do
    
    it{ should_not belong_to(:user) }
    
    specify 'users have many posts' do
      User.should_not have_many(:posts)
    end
    
    specify 'post.delivers owner' do
      Post.new.delivers?(:owner).should be_false
    end
    
    specify 'post delivers ownership' do
      Post.new.delivers?(:ownership).should be_false
    end
    
  end
  context 'when assigned to a user' do
    
    before(:all) do 
      Post.send(:deliver_with, :ownership)
    end
    
    it{ should belong_to(:user) }
    
    specify 'user has many posts' do
      User.should have_many(:posts)
    end
    
    specify 'post delivers ownership' do
      Post.new.delivers?(:ownership).should be_true
    end
    
    pending('depreciate owner for ownership')
    specify 'post delivers owner' do
      Post.new.delivers?(:owner).should be_true
    end
        
  end
  
end