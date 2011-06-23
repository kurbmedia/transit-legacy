require 'spec_helper'

describe 'Transit::Model::Paginator' do
  
  subject{ Post }
  
  it{ Post.respond_to?(:page).should be_true }
  it{ Post.respond_to?(:deliver_per_page).should be_true }
  it{ Post.respond_to?(:pagination_options).should be_true }
  
  describe 'paginating documents' do
    
    before(:all) do 
      Post.deliver_per_page(10, admin: 20)
      10.times{ |i| Fabricate(:post, title: "Post #{i+1}", post_date: i.days.ago) } 
    end
    def pagination(pg, per); Post.descending(:post_date).page(pg, per: per); end
    
    its(:count){ should == 10 }
    
    context '.page(1, per: 2)' do
      
      let(:page){ pagination(1, 2) }
      subject{ page } 

      describe 'the resulting criteria' do 
        subject{ page.options }
        its(:keys){ should include(:limit, :skip) }
        it 'limit should be 2' do
          page.options[:limit].should == 2
        end
        it 'skip should be 0' do
          page.options[:skip].should == 0
        end
        it{ page.current_page.should == 1 }
      end
      
      its(:size){ should == 2 }
      its(:total_pages){ should == 5 }
      it { subject.first.title.should == 'Post 1' }
      it { subject.first.should be_a(Post) }
      
    end
    
    context 'with default options' do
      
      subject{ Post.page(1) }
      its(:size){ should == 10 }
      its(:count){ should == 10 }
    end
    
  end
  
end