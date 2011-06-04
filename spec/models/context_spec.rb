require 'spec_helper' 

describe Transit::Context do
  
  describe 'requiring all engine contexts' do
    specify{ Object.const_defined?('Audio').should be_true }
    specify{ Object.const_defined?('Text').should be_true }
    specify{ Object.const_defined?('Video').should be_true }
  end
  
  it{ should be_embedded_in(:package) }
  
end