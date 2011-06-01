require 'spec_helper'

describe Transit::Mapping do
  
  before(:all) do
    @mapping = Transit::Mapping.new(:article)
    @mapping.build
  end
  subject{ @mapping }
  
  its(:controller_name){ should == "PostsController" }
  its(:resource_controller){ should == "ArticlesController" }
  
  context 'when generating controllers' do
    subject{ Transit }
    
    its(:constants){ should include(:PostsController) }
    its(:constants){ should include(:ArticlesController) }
    
    describe 'the controller subclass' do
      
      context 'when a post package' do
        subject{ Transit::ArticlesController }
        its(:superclass){ should == Transit::PostsController }
      end
      
    end
  end
  
  
end