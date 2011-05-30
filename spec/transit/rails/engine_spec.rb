require 'spec_helper' 

describe 'Transit::Engine' do
  
  subject{ Transit }
  context 'when generating controllers' do
    
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