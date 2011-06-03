require 'spec_helper'

describe 'base models' do
  
  describe 'Post types' do
  
    subject{ Post }
    it{ should embed_many(:contexts) }    
  end
  
  describe 'Page types' do
  
    subject{ Page }
    it{ should embed_many(:contexts) }    
  end
  
end