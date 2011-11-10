require 'spec_helper'
require 'transit/orm/mongoid'

describe "Commenting within mongoid models" do
  
  subject do
    class TestPost
      include Mongoid::Document
      deliver_as :post
      deliver_with :comments
    end
    TestPost
  end
  
  its(:instance_methods){ should include(:comments) }
  its(:instance_methods){ should include(:comment_count) }
  
end