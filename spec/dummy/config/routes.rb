Rails.application.routes.draw do
  # transit :post
  # mount Transit::Engine => "/transit"
  root to: 'index#index'
end
