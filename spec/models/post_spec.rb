require 'spec_helper'

describe Post do
  
  after{ Post.delete_all }
  
  it { Post.respond_to?(:deliver_as).should be_true }
  it { Post.respond_to?(:deliver_with).should be_true }
  
  describe 'any instance' do
    
    its(:fields){ should include('title') }
    its(:fields){ should include('post_date') }
    its(:fields){ should include('published') }
    its(:fields){ should include('slug') }
    its(:fields){ should include('teaser') }
    its(:fields){ should include('default_teaser') }    
    it { should embed_many(:contexts) }
  end
  
  describe 'creating posts' do
    
    before{ @post = Fabricate.build(:post, :title => 'Test Post') }    
    subject{ @post }
    
    describe 'uid' do
      before{ @post.save }
      specify{ @post.uid.should_not be_nil }
      specify{ @post.uid.should == 1}
    end
    
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
  
  describe 'creating or saving posts' do
    before do 
      @post = Fabricate.build(:post, :title => 'Test Post')
      @post.contexts.build({ body: '<p>paragraph1</p><p>paragraph2</p>' }, Text)
    end
    
    it 'creates a default teaser from the body copy' do
      expect{
        @post.save
      }.to change(@post, :default_teaser).from('').to("paragraph1")
    end
    
  end
  
  describe '#published scope' do
    
    let!(:published){ Fabricate(:post, published: true, post_date: Date.today) }
    let!(:unpublished){ Fabricate(:post, published: true, post_date: 2.days.from_now) }
    let!(:unpublished2){ Fabricate(:post, published: false, post_date: 2.days.ago) }
    
    subject{ Post.published.to_a }
    it { should_not include(unpublished, unpublished2) }
    it { should_not include(unpublished) }
    it { should_not include(unpublished2) }
    it { should include(published) }
    
  end
  
end