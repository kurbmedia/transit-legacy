Rails.application.routes.draw do
  mount Transit::Engine => "/transit"  
end

Transit::Engine.routes.draw do
  root :to => 'index#index'
end