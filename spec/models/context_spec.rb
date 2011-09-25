require 'spec_helper' 

describe Transit::Context do
  
  it "has a polymorphic association to package" do
    Transit::Context.reflect_on_association(:package)[:name].to_s.should == "package"
  end

end