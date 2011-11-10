require 'spec_helper'

describe "Asset" do

  it "creates a deliver_as method" do
    Transit::Asset.respond_to?(:deliver_as).should be_true
  end

  it "should belong_to a polymorphic assetable" do
    Transit::Asset.new.respond_to?(:assetable).should be_true
  end
  
  it "includes Paperclip::Glue" do
    Transit::Asset.included_modules.should include(Paperclip::Glue)
  end
  
  describe "identificaton" do
    
    subject do
      Transit::Asset.new(attrs)
    end
    
    context "when an image" do

      let(:attrs) do
        { file_content_type: 'image/jpeg' }
      end
      
      it "image? should be true" do
        subject.image?.should be_true
      end
      
      specify "audio? and video? should be false" do
        subject.audio?.should be_false
        subject.video?.should be_false
      end
      
    end
    
    context "when a video" do
      
      let(:attrs) do
        { file_content_type: 'video/mp4'}
      end
      
      it "audio? should be true" do
        subject.video?.should be_true
      end
      
    end
    
  end
  
  context "when creating" do
    
    
    
  end
  
end