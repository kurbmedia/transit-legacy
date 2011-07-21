require 'spec_helper' 

describe 'Transit::Engine' do
  
  subject{ Dummy::Application }

  describe 'configuration' do
    
    it 'adds a config.transit method' do
      subject.config.respond_to?(:transit).should be_true
    end
    
    describe 'config.transit' do
      subject{ Dummy::Application.config.transit }

      it{ should == Transit::Config }
    end
    
  end
  
end