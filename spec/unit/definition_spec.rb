require 'spec_helper'

describe "Package Definitions" do
  
  [Post, Page].each do |klass|
    it "#{klass} applies a deliver_as method" do
      klass.respond_to?(:deliver_as).should be_true
    end
    
    it "#{klass} applies a create_transit_schema method" do
      klass.respond_to?(:apply_transit_schema).should be_true
    end
  end
  
end