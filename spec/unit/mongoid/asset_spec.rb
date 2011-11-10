require 'spec_helper'
require 'transit/orm/mongoid'

describe "Assets" do

  describe "fields" do

    subject do
      Transit::Asset
    end

    its(:fields){ should include('name') }
    its(:fields){ should include('meta') }
    its(:fields){ should include('file_file_name') }
    its(:fields){ should include('file_content_type') }
    its(:fields){ should include('file_file_size') }
    its(:fields){ should include('file_updated_at') }
    its(:fields){ should include('file_fingerprint') }
    its(:fields){ should include('file_type') }
  
  end

  it "includes Mongoid::Document" do
    Transit::Asset.included_modules.should include(Mongoid::Document) 
  end
  
end