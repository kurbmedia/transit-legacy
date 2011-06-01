module Transit
  class Page
    include Mongoid::Document   
    include Mongoid::Timestamps
    include Mongoid::MultiParameterAttributes
    include Transit::Pages
    
    store_in :pages
    
    
  end
end