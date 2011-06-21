require 'spec_helper'

describe Transit::Builders::Forms do

  include HelperMacros
  before do
    mock_everything
    ActionView::Base.send :include, TransitHelper
    @template = ActionView::Base.new
    @template.stubs(:users_path).returns('')
    @template.stubs(:url_for).returns('')
    @template.stubs(:protect_against_forgery?).returns(false)
    @template.output_buffer = ""
  end 
  
  let!(:builder){ Transit::Builders::Forms.new(:user, @user, @template, {}, proc {}) }

end