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
    
    context 'when controller is set to false' do
      
      it 'does not generate a controller' do
        Transit::CONTROLLERS.should_not include('TestNoControllers')
      end
      specify{ Transit.const_defined?('TestNoControllersController').should be_false }
    end
    context 'when controller is not set' do
      
      it 'generates a controller' do
        Transit::CONTROLLERS.should include('TestPosts')
      end
    end
  end
  
end