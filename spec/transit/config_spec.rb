# require 'spec_helper'
# 
# describe Transit::Config do
#   
#   it 'contains asset configuration' do
#     Transit::Config.respond_to?(:assets).should be_true
#   end
#   
#   describe 'configuring assets' do
# 
#     before(:all) do
#       Transit::Config.assets.path    = "/test/path"
#       Transit::Config.assets.storage = :s3
#     end    
#     
#     context 'when setting options' do
#       subject{ OpenStruct.new(Transit::Asset.asset_config_with_default) }
#       
#       its(:storage){ should == :s3 }
#       its(:path){ should == '/test/path' }
#     end
#   end
#   
# end