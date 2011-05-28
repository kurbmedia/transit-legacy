require 'spec_helper'

describe 'a post package' do
  extend ModelHelpers
  
  context 'on create' do
    
    generate_full_post 
    it 'slugs the title on save' do
      subject.slug.should == subject.title.to_slug
    end
    
    context 'when subclassed' do
      
      subject{ Fabricate.build(:post, :_type => 'Article') }
      before{ subject.save }
      it 'slugs the title on save' do
        subject.slug.should == subject.title.to_slug
      end
      specify{ Post.find(subject.id).should be_a(Article) }
    end
  end
  
  describe 'any instance' do

    generate_full_post
    
    describe '.teaser' do
      context 'when the teaser attribute is not set' do
        
        change_and_reset_attribute('post','teaser', nil)
        its(:teaser){ should_not be_nil }
        specify{ subject.attributes['teaser'].should be_nil }
      end
      context 'when the teaser attribute is set' do

        its(:teaser){ should_not be_nil }
        specify{ subject.teaser.should == subject.attributes['teaser'] }
      end
    end
    
  end
  
  
end