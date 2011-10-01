Transit::Engine.routes.draw do
  resources :posts
  resources :pages
  resources :package_assets, path: '/transit/package-assets'
end