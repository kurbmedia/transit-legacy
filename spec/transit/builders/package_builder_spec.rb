require 'spec_helper'

Transit::Admin.register(:post) do |conf|
  conf.fields title: :text_field, teaser: :text_area
end
  
describe 'the package builder' do
  
  include HelperMacros
  before do
    mock_everything
    ActionView::Base.send :include, TransitHelper
    @template = ActionView::Base.new
    @template.stubs(:users_path).returns('')
    @template.stubs(:url_for).returns('')
    @template.stubs(:protect_against_forgery?).returns(false)
    @template.output_buffer = ""
    @form    = Transit::Builders::FormBuilder.new(:user, @post, @template, {}, proc {})
    @builder = Transit::Builders::PackageBuilder.new(@post, @form)
  end 
  before(:all){ @post = Fabricate(:post, title: 'Builder Post', contexts: [ Text.new(body: "<p>Sample post body</p>") ]) }
  
  let(:form){ @form }
  let(:builder){ @builder }
  
  subject{ @builder }
  
  its(:template){ should be_a(ActionView::Base) }
  its(:form){ should be_a(Transit::Builders::FormBuilder) }
  
  describe 'delegating methods to its resource' do
    context 'when title is a text_field and teaser is a text_area' do
      
      [[:title, :text_field], [:teaser, :text_area]].each do |opts|      
        it "delegates #{opts.first} to form's #{opts.last}" do
          form.expects(opts.last).with(opts.first).once
          builder.send(opts.first)
        end      
      end
      
    end  
  end
  
end