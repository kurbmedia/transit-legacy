require 'spec_helper'

describe 'a Transit::Package' do
  extend ModelHelpers
    
  subject{ Post }  
  describe 'an instance' do
    
    let!(:post){ Fabricate.build(:post) }
    subject{ post }
    after{ Post.delete_all }
    it { subject.respond_to?(:contexts).should be_true }
    it { subject.respond_to?(:contexts=).should be_true }
    
    context 'when saved' do
      
      before(:all){ subject.save }
      its(:uid){ should_not be_nil }
    end    
    context 'when adding a context' do
      
      generate_post(1)      
      before{ post1.contexts.build(Fabricate.attributes_for(:context), ContextField); post1.save }
      its(:contexts){ should_not be_empty }
      
      describe 'the context' do
        
        subject{ post1.contexts.first }
        it 'can be found by its id' do
          lambda{ post1.contexts.find(subject.id) }.should_not raise_error
        end
      end      
    end    
    describe '.context_named' do
      
      generate_post(1)
      before{ post1.contexts.build(Fabricate.attributes_for(:context, :name => 'Test Name'), ContextField); post1.save }
      it { subject.respond_to?(:context_named).should be_true }
      it 'finds the context with that name' do
        subject.context_named('Test Name').should_not be_nil
      end
      specify{ subject.context_named('Test Name').should be_a(ContextField) }
    end
  end  
  describe '.uid' do
    
    generate_post(2, true)
    after{ Post.delete_all }    
    its(:uid){ should_not == @post2.uid }
    its(:uid){ should == (@post2.uid - 1) }    
  end
  
  describe 'nested attributes' do
    
    before(:all){ @post = Fabricate(:post) }
    let!(:post){ @post }
    subject{ post }
    after(:all){ Post.delete_all }
          
    context 'when passed attributes for a new context' do
      
      before{ 
        post.contexts_attributes = { "0" => Fabricate.attributes_for(:context).merge!('_type' => 'BodyCopy', 'position' => 1) } 
        post.save
      }
      it 'ensure the context class is correct' do
        post.contexts.first.should be_a(BodyCopy)
      end
    end    
    context 'when passed attributes for existing contexts' do      
      context 'when re-ordering' do
        
        create_contexts('post', :all, BodyCopy, Heading)
        def reposition_fields(opts)
          new_hash = {}
          post.contexts.collect{ |con, i|  con.position = opts[con.class.name.to_s]; con }.each_with_index{ |c, i| new_hash.merge!(i.to_s => c.attributes) }
          new_hash
        end        
        it 're-orders the fields on save' do
          post.contexts_attributes = reposition_fields({ "BodyCopy" => 1, "Heading" => 0 })
          post.save
          post.reload
          post.contexts.ascending(:position).first.class.should == Heading
        end
      end
    end
  end
    
end