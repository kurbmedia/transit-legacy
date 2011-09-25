require 'spec_helper'

describe Post do
  extend ModelHelpers
  
  describe 'instance methods' do
    
    subject{ Post.new }
    
    its(:methods){ should include(:published?) }
    its(:methods){ should include(:teaser) }
    its(:methods){ should include(:title) }
    its(:methods){ should include(:post_date) }
    its(:methods){ should include(:contexts) }
    its(:methods){ should include(:contexts_attributes=) }
    
  end
  
  describe 'class methods' do

    subject{ Post }    
    its(:methods){ should include(:published) }
  end
  
  describe "published scope" do
    before(:all) do
      Fabricate(:post, :post_date => 1.year.ago.to_time, :published => true)
      Fabricate(:post, :post_date => 1.year.from_now.to_time, :published => true)
      Fabricate(:post, :post_date => 1.year.ago.to_time, :published => false)
    end
    
    it "only finds posts which are published and older than today" do
      Post.published.count == 1
    end
    
  end
  
  describe "post properties" do
    
    context "when published" do
      generate_post(1, { published: true })
      
      it "validates the title" do
        post1.title.should_not be_nil
      end      
      
      it "makes a slug from the title" do
        post1.slug.should eq(post1.title.to_slug)
      end
      
    end    
  end
  
  describe "creating contexts" do
    
    describe "creating a new context" do
      
      generate_post(1, { published: true }, true)
      
      before do
        post1.contexts_attributes = { "0" => { "_type" => "Text", "body" => "Sample text body" }}
        post1.save
      end
      
      context "when no contexts exist" do
        it 'adds a context' do
          post1.contexts.count.should == 1
        end
      
        it "assigns the proper STI class to the context" do
          post1.contexts.first.class.should == Text
        end            
      end
      
      context "when contexts exist" do
        
        before do
          post1.contexts_attributes = { "0" => { "_type" => "Text", "body" => "Sample text body" }, "1" => post1.contexts.first.attributes }
          post1.save
        end
        
        it 'adds a context' do
          post1.contexts.count.should == 2
        end
      
        it "assigns the proper STI class to the context" do
          post1.contexts.last.class.should == Text
        end
        
        after do
          post1.contexts.last.delete
        end
      end
    end
    
    describe "updating an existing context" do
      
      generate_post(1, { published: true }, true, :all)
      
      before(:all) do
        post1.contexts_attributes = { "0" => { "_type" => "Text", "body" => "Sample text body" }}
        post1.save        
      end
   
      let(:cxt){ post1.contexts.first }
      
      it 'should update the context inline' do
        expect{
          post1.contexts_attributes = { "0" => { "id" => cxt.id.to_s, "_type" => "Text", "body" => "Sample text body" }}
          post1.save
        }.to_not change(post1.contexts, :count)
      end      
    end
  
  end
  
end