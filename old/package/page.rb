module Transit::Package
  module Page
    
    extend ActiveSupport::Concern
    
    included do
      class_attribute :delivery_template, instance_writer: false
      self.delivery_template = :page
      
      include Transit::Model::Base      
      
      field :name,        type: String
      field :url,         type: String
      field :keywords,    type: Array
      field :description, type: String
      
      embeds_many :contexts, as: :package, class_name: 'Transit::Context'      
    end
    
    def timestamp
      return "" if self.post_date.nil?
      self.post_date.strftime("%B %d, %Y")
    end
  
  end
end