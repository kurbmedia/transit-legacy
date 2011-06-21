require 'active_support'

module HelperMacros
  
  # Mock everything needed to simulate a live "View"
  def mock_everything
  
    # Mock path helpers for forms
    def users_path;   "/users"; end
    def user_path(i); "/users/1"; end
    def protect_against_forgery?; false; end
  
    User.any_instance.stubs(:persisted?).returns(false)  
    @user = Fabricate.build(:user)  
    @valid_user = Fabricate.build(:user)
    @valid_user.stubs(:valid?).returns(true)
  
    @invalid_user = Fabricate.build(:user)
    @invalid_user.stubs(:valid?).returns(false)   
  end
  
  def stub_template_instance
    @template = ActionView::Base.new
    @template.stubs(:users_path).returns('')
    @template.stubs(:url_for).returns('')
    @template.stubs(:protect_against_forgery?).returns(false)
    @template.output_buffer = ""
  end
    
end

module MockedView
  extend ActiveSupport::Concern
  
  
  included do
    include ActionPack
    include ActionView::Context if defined?(ActionView::Context)
    include ActionController::RecordIdentifier
    include ActionView::Helpers::FormHelper
    include ActionView::Helpers::FormTagHelper
    include ActionView::Helpers::FormOptionsHelper
    include ActionView::Helpers::UrlHelper
    include ActionView::Helpers::TagHelper
    include ActionView::Helpers::TextHelper
    include ActionView::Helpers::ActiveRecordHelper if defined?(ActionView::Helpers::ActiveRecordHelper)
    include ActionView::Helpers::ActiveModelHelper if defined?(ActionView::Helpers::ActiveModelHelper)
    include ActionView::Helpers::DateHelper
    include ActionView::Helpers::CaptureHelper
    include ActionView::Helpers::AssetTagHelper
    include ActiveSupport
    include ActionController::PolymorphicRoutes if defined?(ActionController::PolymorphicRoutes)    
    attr_accessor :output_buffer      
  end
  
  module ClassMethods
    def include_helper(const)
      ActionView::Base.send :include, const
    end
    def mock_view
      before do        
        @template = ActionView::Base.new
        @template.output_buffer = ""   
      end
      let!(:template){ @template }
    end
  end
  
end

class ActiveSupport::SafeBuffer  
  def to_html
    Capybara.string(self)
  end
end

class String
  def to_html
    Capybara.string(self)
  end
end