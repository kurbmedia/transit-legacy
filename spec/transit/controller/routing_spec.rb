require 'spec_helper'
  
describe TransitController, :type => :controller do
  
  subject{ controller }
  
  describe 'adding route helpers dynamically' do
    its(:methods){ should include(:new_article_path) }
    its(:methods){ should include(:article_path) }
    its(:methods){ should include(:articles_path) }
    its(:methods){ should include(:new_article_path) }
  end
  
end