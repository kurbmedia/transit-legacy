require 'spec_helper'

describe Transit do
  
  before(:all) do
    Transit.track('Post', :post)
  end
  
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
    
    it 'responds to lookup' do
      subject.respond_to?(:lookup).should be_true
    end
    it 'returns an array of classes using the passed template' do
      Transit.lookup(:post).should be_a(Array)
    end
    specify do
      Transit.lookup(:post).should include('Post')
    end
  end
  
  describe '#contexts' do
    
    it 'responds to contexts' do
      subject.respond_to?(:contexts).should be_true
    end
    it 'returns an array of all available contexts' do
      Transit.contexts.should be_a(Array)
    end
    specify do
      Transit.contexts.should include('Text', 'Video')
    end
  end
  
  describe '#superclass_for' do
    
    specify do
      Transit.superclass_for(:post).should == 'Post'
    end
    specify do
      Transit.superclass_for(:page).should == 'Page'
    end
  end
  
  describe '#configure' do
    
    it 'yields Transit::Config' do
      Transit.configure do |conf| 
        conf.should == Transit::Config
      end
    end
  end
  
end