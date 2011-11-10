Transit::Admin::Engine.routes.draw do
  resources :posts
  resources :pages
  resources :package_assets, :controller => 'assets', :path => 'package-assets'
end