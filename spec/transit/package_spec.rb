require 'spec_helper' 

describe 'Package::Hook' do
  
  class TestPost
    include Mongoid::Document
    transit :post
  end
  class TestNoController
    include Mongoid::Document
    transit :post, :controller => false
  end
  subject{ TestPost }
  
  it 'tracks the class with template' do
    Transit.lookup(:post).should be_a(Array)
  end
  specify{ Transit.lookup(:post).should include('TestPost') }
  
  describe 'configuration' do
    
    it { subject.respond_to?(:transit_config).should be_true }    
    describe 'its template' do
      
      subject{ TestPost.transit_config }
      it { subject[:template].should == :post }
    end
  end
  
end