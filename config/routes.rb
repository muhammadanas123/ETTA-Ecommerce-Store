Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "home#index"
  devise_for :users
  resources :products do
    resources :orders
    resources :comments, except: [:show, :index]
  
  end
  
end
