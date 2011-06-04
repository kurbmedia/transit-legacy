require 'spec_helper'

describe 'controller generation' do
  
  subject{ Transit }
  describe 'new controllers' do
    
    its(:constants){ should include(:PostsController) }
    its(:constants){ should include(:BlogsController) }
    its(:constants){ should include(:ArticlesController) }
  end
  
  describe 'post controller superclasses' do
    
    specify{ Transit::BlogsController.superclass.should == Transit::PostsController }
    specify{ Transit::ArticlesController.superclass.should == Transit::PostsController }
  end
  
end