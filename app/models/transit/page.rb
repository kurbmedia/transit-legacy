module Transit
  class Page
    include Mongoid::Document   
    include Mongoid::Timestamps
    include Mongoid::MultiParameterAttributes
    include Transit::Pages
    
    store_in :pages
    has_and_belongs_to_many :assets, :class_name => 'Transit::Asset'
    
    
  end
end