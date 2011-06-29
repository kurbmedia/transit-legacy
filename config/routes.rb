Transit::Engine.routes.draw do
  resources :posts
  resources :pages
  match '/assets/remove/:id', controller: 'assets', action: 'destroy', as: 'delete_asset', via: :delete
  resources :package_assets, :controller => 'assets'
end