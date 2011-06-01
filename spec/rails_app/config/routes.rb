Rails.application.routes.draw do
  
  mount Transit::Engine => "/transit"
  transit :post
  
end