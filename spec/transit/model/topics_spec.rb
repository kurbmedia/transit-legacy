require 'spec_helper'

describe 'Comments' do
  
  before(:all){ Post.send(:deliver_with, :topics) }
  subject{ Post }
  
  it{ should have_and_belong_to_many(:topics) }
  specify{ Topic.should have_and_belong_to_many(:posts) }
  
end