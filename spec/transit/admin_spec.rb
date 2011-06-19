require 'spec_helper'

describe Transit::Admin do
  
  it { Transit::Admin.respond_to?(:register).should be_true }
  it { Transit::Admin.respond_to?(:options_for).should be_true }
  specify do
    Transit::Admin.register(:post) do |conf|
      conf.should be_a(Transit::Admin::DSL)
    end
  end
  
  describe 'configuring resources' do
    
    before(:all){ Transit::Admin.register(:post){ |conf| conf.columns :post_date, :title } }
    subject{ Transit::Admin.options_for(:post) }
    it { should be_a(Transit::Admin::DSL) }
    its(:column_hash){ should_not be_nil }
    it { subject.column_hash.keys.should include(:post_date, :title) }
  end
  
  describe 'configuring columns' do
    
    before(:all){ Transit::Admin.register(:post){ |conf| conf.columns :post_date, title: { as: 'Post Title' }, timestamp: { as: 'Post Date', proc: lambda{ |p| p } } } }
    let(:options){ Transit::Admin.options_for(:post).column_hash }
    subject{ options }
    
    its(:keys){ should include(:post_date, :title, :timestamp) }    
    context 'when only a symbol is passed' do
      subject{ options[:post_date] }
      
      it { should be_a(String) }
      it { should == "Post Date" }
    end
    context 'when a hash with :as is passed' do
      subject{ options[:title] }
      
      it{ should be_a(String) }
      it{ should == 'Post Title' }
    end
    context 'when a proc is passed' do
      subject{ options[:timestamp] }
      
      it { should be_a(Array) }
      it { subject.first.should be_a(String) }
      it { subject.last.should be_a(Proc) }
    end
  end
  
end