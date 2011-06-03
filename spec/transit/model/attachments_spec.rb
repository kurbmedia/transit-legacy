require 'spec_helper'

describe 'model attachments' do
  
  subject{ Post }
  before(:all){ Post.send(:deliver_with, :attachments) }
  
  its(:included_modules){ should include(Paperclip::Glue) }
  it { Post.respond_to?(:has_attached_file).should be_true }
  it { Post.respond_to?(:attach).should be_true }
  
  context 'when adding an attachment' do
    
    before(:all){ Post.send(:attach, :photo) }
    its(:fields){ should include('photo_file_name') } 
    its(:fields){ should include('photo_content_type') }
    its(:fields){ should include('photo_updated_at') }
    its(:fields){ should include('photo_fingerprint') }
  end
  
end