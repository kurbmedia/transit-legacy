Transit::Engine.routes.draw do
  resources :posts
  resources :pages
  resources :contexts
  resources :package_assets, :controller => 'assets'
end