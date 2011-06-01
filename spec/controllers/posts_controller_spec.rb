require 'spec_helper'

describe Transit::PostsController do
  extend ControllerHelpers
  
  stub_resource(Post)
  
  subject{ controller }
  its(:scope_class){ should == Post }
  
  describe 'GET #index' do

    before{ get :index, :use_route => :transit }
    specify{ response.should be_success }
    it 'assigns a variable representing the scope class' do
      assigns[:posts].should_not be_nil
    end
    it 'assigns a collection variable' do
      assigns[:posts].should == controller.collection      
    end
    it 'assigns a collection with the proper class' do
      Post.expects(:all).once
      Article.expects(:all).never
      get :index, :use_route => :transit
    end
    specify{ assigns[:posts].should be_a(Array) }
  end
  
  describe 'GET #show' do
    
    before{ get :show, :id => resource.id.to_s, :use_route => :transit }
    specify{ response.should be_success }
    it 'assigns a singluar variable representing the scope class' do
      assigns[:post].should_not be_nil
    end
    it 'assigns a resource variable' do
      assigns[:post].should == controller.resource
    end
  end
  
end
class Transit::ArticlesController < Transit::PostsController
end

describe Transit::ArticlesController do
  subject{ controller }
  its(:scope_class){ should == Article }
end