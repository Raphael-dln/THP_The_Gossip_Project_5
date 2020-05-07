Rails.application.routes.draw do
  # Accueil
  root 'gossips#index'

  # REST routes
  resources :gossips
  resources :users
  resources :cities, only: [:show]
  resources :comments
  resources :sessions, only: [:new, :create, :destroy]
  resources :likes, only: [:create, :destroy]
  
  
  # menu (static pages)
  get 'welcome/:user_entry', to: 'welcome#show', as: 'user_entry'
  get '/team', to: 'static_pages#team'
  get '/contact', to: 'static_pages#contact'
end
