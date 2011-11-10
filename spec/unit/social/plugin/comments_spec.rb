require 'spec_helper'
describe "Commenting" do
  
  before(:all) do
    Post.send(:delivers, :comments)
    @post = Fabricate(:post)
  end

  subject{ @post }
  
  it{ @post.respond_to?(:comments).should be_true }
  it{ @post.respond_to?(:comment_count).should be_true }
  
  describe "a comment" do
    
    subject{ Comment.new }    
    
    it{ subject.respond_to?(:body).should be_true }
    it{ subject.respond_to?(:created_at).should be_true }
    it{ subject.respond_to?(:updated_at).should be_true }
    
  end
  
  describe 'validations' do
    
    it "requires the presence of a user" do
      comment = Comment.new({ commentable: @post, body: "test body" })
      comment.valid?.should be_false
    end
    
  end
  
  describe 'adding a comment' do
    
    before(:all) do
      @comment = @post.comments.create({ body: "this is some comment action" })
    end

    describe 'the comment' do
      
      it 'is commentable to the post' do
        @comment.commentable.should == @post
        @comment.commentable.respond_to?(:comment_count).should == true
      end
      
      it 'increments the posts comment count' do
        expect{
          com = @post.comments.build({ body: "sample body" })
          com.save(validate: false)
        }.to change(@post, :comment_count).by(1)
      end
      
    end
    
  end
  
  describe 'deleting a comment' do
    
    before(:each) do
      @post.comments.delete_all
      @comment = @post.comments.build({ body: "some test comment" })
      @comment.save(validate: false)
    end
    
    it "subtracts one from the comment count when deleted" do
      expect{
        @comment.destroy
      }.to change(@post, :comment_count).by(-1)
    end
    
  end
  
end