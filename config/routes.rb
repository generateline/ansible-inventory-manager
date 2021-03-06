AnsibleWebInventory::Application.routes.draw do
  # Omniauth
  match 'auth/:provider/callback', to: 'sessions#create', via: [:get, :post]
  match 'auth/failure', to: redirect('/'), via: [:get, :post]

  match 'signin', to: 'sessions#new', as: 'signin', via: [:get, :post]
  match 'signout', to: 'sessions#destroy', as: 'signout', via: [:get, :post]

  # Auth
  resources :identities

  # Inventory
  resources :inventories do
    resources :hosts
    resources :groups
  end

  get '/administration', to: 'administration#user'

  # Ansible API
  mount API::API => '/api'

  # User
  resources :user

  # statics
  get '/help', to: 'static_pages#help'

  # Root
  root to: redirect('/inventories')
end
