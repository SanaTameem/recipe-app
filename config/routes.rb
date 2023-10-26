# frozen_string_literal: true

Rails.application.routes.draw do
  
  root to: 'foods#index'
  devise_for :users

  resources :recipes, only: [:index, :create, :new, :show, :destroy] do
    resources :recipe_foods, only: [:index, :new, :create, :edit, :update]
  end
  resources :foods, only: [:index, :show, :new, :create, :destroy]
  resources :public_recipes, only: [:index]
  resources :general_shopping_list, only: [:index]

  resources :recipes do
    resources :recipe_foods
  end

  resources :recipes do
    member do
      put 'toggle_public'
    end
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end