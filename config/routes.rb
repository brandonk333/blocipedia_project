Rails.application.routes.draw do
  devise_for :users
  
  resources :wikis do
    resources :collaborators, only: [:create, :destroy]
  end
  
  resources :charges, only: [:new, :create]
  
  get 'about' => 'welcome#about'
  get 'downgrade' => 'users#downgrade'
  
  root 'welcome#index'
  
end
