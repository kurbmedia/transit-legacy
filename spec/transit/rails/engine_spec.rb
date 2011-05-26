require 'spec_helper' 

describe 'Transit::Engine' do
  
  subject{ Transit }
  describe 'dynamic controller creation' do
    its(:constants){ should include(:PostsController) }
    its(:constants){ should include(:ArticlesController) }
  end
  
end