require 'spec_helper'

describe Page do
  
  describe 'instance methods' do    
    subject{ Page.new }    
    its(:methods){ should include(:published?) }
    its(:methods){ should include(:keywords) }
    its(:methods){ should include(:title) }
    its(:methods){ should include(:description) }
    its(:methods){ should include(:contexts) }
    its(:methods){ should include(:contexts_attributes=) }
  end
  
  context "with validation option" do
    
  end
  
end