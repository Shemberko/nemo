Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :posts
  resources :post_categories
  # Defines the root path route ("/")
  #root "articles#index"
  root "home#index"
  resources :posts do
    delete :destroy, on: :member
  end
end
