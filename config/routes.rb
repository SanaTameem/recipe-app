Rails.application.routes.draw do
  resources :recipes, only: [:index, :show, :new, :create, :destroy]
  devise_for :users
  root to: 'foods#index'
  resources :foods, only: [:index, :show, :new, :create, :destroy]
  resources :general_shopping_list, only: [:index]
  resources :recipes do
    member do
      put 'toggle_public'
    end
  end

  # resources :recipes do
  #   resources :recipe_foods
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end