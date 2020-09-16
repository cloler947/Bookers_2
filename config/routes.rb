Rails.application.routes.draw do
  devise_for :users
  root 'homes#home'
  get 'home/about', to: 'homes#about'
  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :books do
    resources :book_comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
