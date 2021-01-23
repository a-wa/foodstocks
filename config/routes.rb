Rails.application.routes.draw do
    
    root to: 'toppages#index'
    
    get 'login', to: 'sessions#new'
    post 'login', to: 'sessions#create'
    delete 'logout', to: 'sessions#destroy'
    
    get 'signup', to: 'users#new'
    
    get 'top', to: 'toppages#index'
    
    resources :users, only: [:index, :show, :create, :edit, :update]
    
    resources :families, only: [:new, :create]
    resources :requests, only: [:new, :create, :update, :destroy]
    
    resources :foods
    
    resources :memos, only: [:create, :destroy]
    
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
