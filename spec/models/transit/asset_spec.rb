require 'spec_helper'

describe Transit::Asset do
  
  after{ Transit::Asset.delete_all }
  
  describe '.file_type' do
    before do
      @asset = Transit::Asset.create({        
        file_file_size: "8192",
        file_updated_at: nil
      }.merge(file_params))
    end
    subject{ @asset }
    
    [['image','.jpg'], ['audio','.mp3'], ['video', '.mp4']].each do |opts|
      
      context "when #{opts.first}" do
        let!(:file_params){ { file_file_name: "example#{opts.last}" } }
        its(:file_type){ should == opts.first }
      end
    end
    
  end
  
end