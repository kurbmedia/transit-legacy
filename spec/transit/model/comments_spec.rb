require 'spec_helper'

describe 'Comments' do
  
  before(:all){ Post.send(:deliver_with, :comments) }
  subject{ Post }
  
  it{ should have_many(:comments) }
  its(:fields){ should include('comment_count') }
  
end