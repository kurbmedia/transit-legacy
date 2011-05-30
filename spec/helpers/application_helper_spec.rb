require 'spec_helper'

describe ApplicationHelper do
  
  describe 'inheriting transit helpers' do
    it { helper.respond_to?(:transit).should be_true }
  end
  
end