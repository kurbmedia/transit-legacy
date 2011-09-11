require 'spec_helper'

describe 'model hooks' do
  
  class TempModel
    include Mongoid::Document
    plugin :auto_increment
    field :title, type: String
    field :something, type: String
    slug_with :title
  end
  
  subject{ Post }
  its(:methods){ should include(:deliver_as) }
  its(:methods){ should include(:deliver_with) }
  
  describe 'adding attachments' do
    
    before{ Post.send(:deliver_with, :attachments) }
    its(:included_modules){ should include(Transit::Model::Attachments) }
  end
  
  describe 'adding comments' do
    
    before{ Post.send(:deliver_with, :comments) }
    its(:included_modules){ should include(Transit::Model::Comments) }
  end
  
  describe 'auto_increment' do
    
    it 'adds a before_create callback' do
      TempModel.should have_before_create_callback(:generate_uid)
    end
    
    it 'adds a uid field' do
      TempModel.fields.keys.should include('uid')
    end
    it 'includes Transit::Model::AutoIncrement' do
      TempModel.included_modules.should include(Transit::Model::AutoIncrement)
    end
    it 'adds a generate_uid method' do
      TempModel.new.methods.should include(:generate_uid)
    end
  end
  
  describe 'slug_with' do
    
    let(:model) do 
      TempModel.new(title: 'Test Title', something: 'Something Else')
    end 
    subject{ model }
    
    it 'adds a before_create callback' do
      TempModel.should have_before_create_callback(:generate_slug)
    end
    
    it 'adds a slug field' do
      TempModel.fields.keys.should include('slug')
    end
    its(:methods){ should include(:generate_slug) }
    
    context 'when generating a slug from the specified field' do
      before do
        model.generate_slug
      end
      
      its(:slug){ should == model.title.to_slug }
      its(:slug){ should_not == model.something.to_slug }
    end
  end

  
end