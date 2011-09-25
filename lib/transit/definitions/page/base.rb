require 'transit/definitions/page/metadata'
require 'transit/definitions/page/validations'
require 'transit/definitions/context/association'

module Transit::Definition
  ##
  # Page packages are used for defining content within any given page.
  # 
  # When delivering a model as a page, the following options are available:
  # 
  #   validate: If set to true, titles and post_dates will be validated
  #   managed: If pages are to be managed by an end-user, set this option to true. 
  # 
  # @example Deliver a model as a Page
  # 
  #   class MyPage
  #     deliver_as :page
  #   end
  # 
  # 
  #
  module Page
    include Metadata
    extend ActiveSupport::Concern
    
    included do
      include Transit::Definition::Context::Association
      create_context_association!
      delivery_options.page.reverse_merge!({
        :validate   => true,
        :managed    => false
      })
            
      include Validations if delivery_options.page.validate === true      
    end
  end
end

Transit::Schema.add(:page, {
  :title        => { :type => String, :default => "" },
  :url          => { :type => String, :default => nil },
  :description  => { :type => String, :default => "" },
  :keywords     => { :type => Array,  :default => [] },
  :published    => { :type => Boolean, :default => false }
})