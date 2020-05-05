Rails.application.routes.draw do
  root 'gossips#index'
  resources :gossips
  resources :users
  # menu
  get 'welcome/:user_entry', to: 'welcome#show', as: 'user_entry'
  get '/team', to: 'static_pages#team'
  get '/contact', to: 'static_pages#contact'
end
