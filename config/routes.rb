Transit::Engine.routes.draw do
  match "packages/:scope_name/:scope_id/contexts/new" => 'contexts#new', :as => :new_package_context, :via => [:get]
  match "packages/:scope_name/:scope_id/contexts/:id" => 'contexts#destroy', :as => :package_context, :via => [:delete]
end