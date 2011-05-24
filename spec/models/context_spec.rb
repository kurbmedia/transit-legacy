require 'spec_helper'

describe 'a Transit::Context' do
  extend ModelHelpers
  
  before(:all){ @post = Fabricate(:post) }
  let!(:post){ @post }
  after(:all){ Post.delete_all }
  
  context 'when a direct subclass' do
    
    subject{ ContextField.new }
    its(:fields){ should include("name","meta")}
    
    context 'when saved' do
      
      subject{ post.contexts.first }
      create_contexts('post', :all, ContextField)
      it { should be_a(ContextField) }      
    end
  end
  
  context 'when a secondary subclass' do
    
    subject{ BodyCopy }
    its(:fields){ should include("name","meta")}
    
    context 'and added to the parent' do
      
      create_contexts('post', :all, BodyCopy)
      it 'creates a context with the 2nd subclass type' do
        post.contexts.first._type.should == "BodyCopy"
      end
    end
  end
  
  
end