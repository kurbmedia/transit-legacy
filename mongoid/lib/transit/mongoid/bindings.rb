module Transit
  module Mongoid
    module Bindings      
      def apply_plugin_attribute!(fname, klass, options = {})
        field fname, {type: klass}.merge(options)
      end      
      def apply_page_schema!
        field :name,        type: String
        field :url,         type: String
        field :keywords,    type: Array
        field :description, type: String       
      end      
      def apply_post_schema!
        field :title,           type: String
        field :post_date,       type: Date
        field :slug,            type: String,   default: nil
        field :teaser,          type: String
        field :default_teaser,  type: String,   default: ''
        field :published,       type: Boolean,  default: false
        field :display_image,   type: Boolean,  default: false
      end      
      def apply_contexts!
        embeds_many :contexts, as: :package, class_name: 'Transit::Context'
      end      
    end
  end
end