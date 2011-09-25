require 'spec_helper'

describe Transit do
  
  module VarHolder
    mattr_accessor :result
    @@result = false
  end
  
  describe "hooks" do
      
    [:on_definition, :on_load, :run_load_hooks, :run_definition_hooks].each do |hook|
      it "responds to #{hook}" do
        Transit.respond_to?(hook).should be_true
      end
    end  
    
    it "runs assigned blocks on run_load_hooks" do
      Transit.on_load(:test){ VarHolder.result = !VarHolder.result }        
      expect{ Transit.run_load_hooks(:test) }.to change(VarHolder, :result)
    end
    
    it "runs assigned blocks on run_load_hooks" do
      Transit.on_definition(:deftest){ VarHolder.result = !VarHolder.result }
      expect{ Transit.run_definition_hooks(:deftest) }.to change(VarHolder, :result)
    end  
  end
   
end