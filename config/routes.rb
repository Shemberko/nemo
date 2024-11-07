Rails.application.routes.draw do
  devise_for :users

  # Root page
  root "home#index"

  # Custom route for my_posts
  get 'my_posts', to: 'posts#my_posts', as: :my_posts

  # Routes for posts, including destroy action
  resources :posts do
    resources :comments
  end

  namespace :admin do
    resources :posts, only: %i[create index]
  end

  # Routes for post categories
  resources :post_categories
end
