require 'spec_helper'

describe Transit::Mapping do
  
  before(:all) do
    @mapping = Transit::Mapping.new(:article)
    @mapping.build
  end
  subject{ @mapping }
  
  its(:controller_name){ should == "PostsController" }
  its(:resource_controller){ should == "ArticlesController" }
  
end