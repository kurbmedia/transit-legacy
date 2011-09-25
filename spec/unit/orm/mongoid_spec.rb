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
    describe "it applies the post schema" do
      
      its(:fields){ should include("title") }
      its(:fields){ should include("post_date") }
      it{ should embed_many :contexts }
      
    end
  end
  
end