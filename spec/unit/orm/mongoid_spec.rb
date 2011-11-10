require 'spec_helper'
require 'transit/orm/mongoid'

describe "Mongoid integration" do
  
  subject do
    class TestPost
      include Mongoid::Document
      deliver_as :post
    end
    TestPost
  end
  
  context 'when delivered as post' do
    
    it "includes the post module" do
      subject.included_modules.should include(Transit::Definition::Post)
    end
    
    describe "it ensures Timestamps is included" do
        its(:fields){ should include('created_at') }
        its(:fields){ should include('updated_at') }
    end
    
    describe "it applies the post schema" do
      
      its(:fields){ should include("title") }
      its(:fields){ should include("post_date") }      
      it{ should embed_many :contexts }
      
    end
    
    describe "it should add the auto_increment plugin" do

      its(:fields){ should include("uid") }
      its(:instance_methods){ should include(:generate_uid) }
      
      it "adds a uid on save" do
        post = TestPost.create({ title: "testing" })
        post.reload.uid.should_not be_nil
      end
      
    end
    
  end
  
end