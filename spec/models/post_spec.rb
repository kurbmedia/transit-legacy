require 'spec_helper'

describe Post do
  
  describe 'any instance' do
    
    its(:fields){ should include('title') }
    its(:fields){ should include('post_date') }
    its(:fields){ should include('published') }
    its(:fields){ should include('slug') }
    its(:fields){ should include('teaser') }
    
  end
  
end