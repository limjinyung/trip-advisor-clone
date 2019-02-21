Rails.application.routes.draw do
  get 'sessions/new'
  get 'sessions/create'
  get 'sessions/destroy'

  root 'listings#index'

  resources :users do
    resources :listings 
  end
  resources :sessions, only: [:new, :create, :destroy]

  get 'signup', to: 'users#new', as: 'signup'
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'

  post '/search', to: 'listings#auto_search'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
