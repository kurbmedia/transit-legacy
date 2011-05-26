require 'spec_helper'

describe Transit do
  
  before(:all){ Transit.track('Post', :post) }
  after(:all){ Transit::DESCRIPTIONS = {} }
  
  describe '#add_description' do
    
    it { subject.respond_to?(:track).should be_true }
    
    context 'when adding a description' do
      
      subject{ Transit::DESCRIPTIONS }
      
      its(:keys) { should include(:post) }
      it 'ensures an array for the package key' do
        subject[:post].should be_a(Array)
      end      
    end
  end
  
  describe '#lookup' do
    
    it { subject.respond_to?(:lookup).should be_true }
    it 'returns an array of classes using the passed template' do
      Transit.lookup(:post).should be_a(Array)
    end
    specify{ Transit.lookup(:post).should include('Post') }
  end
  
  describe '#contexts' do
    
    it { subject.respond_to?(:contexts).should be_true }
    it 'returns an array of all available contexts' do
      Transit.contexts.should be_a(Array)
    end
    specify{ Transit.contexts.should include('BodyCopy', 'Heading') }
  end
  
end