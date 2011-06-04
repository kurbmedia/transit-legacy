require 'spec_helper'

describe 'model assets' do
  
  subject{ Post }
  before(:all){ Post.send(:deliver_with, :assets) }
  
  it{ should have_and_belong_to_many(:assets) }

end