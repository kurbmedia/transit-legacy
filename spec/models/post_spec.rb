require 'spec_helper'

describe Post do
  
  it { Post.respond_to?(:deliver_as).should be_true }
  it { Post.respond_to?(:deliver_with).should be_true }
  
  describe 'any instance' do
    
    its(:fields){ should include('title') }
    its(:fields){ should include('post_date') }
    its(:fields){ should include('published') }
    its(:fields){ should include('slug') }
    its(:fields){ should include('teaser') }
    
    it { should embed_many(:contexts) }
  end
  
  context 'when creating' do
    
    before{ @post = Fabricate.build(:post, :title => 'Test Post') }
    after{ Post.delete_all }
    subject{ @post }
    
    context 'when un-published' do
      
      before{ @post.published = false; @post.save }
      its(:slug){ should be_nil }
    end
    context 'when published' do
      
      before{ @post.published = true; @post.save }
      its(:slug){ should == 'test-post' }
      specify{ @post.reload.slug.should == 'test-post' }
    end
    
  end
  
end