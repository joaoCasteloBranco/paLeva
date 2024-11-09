Rails.application.routes.draw do
  devise_for :users

  root "home#index"

  resources :restaurants do

    resources :operating_days, only: [:new, :create, :update, :edit, :show]

    resources :markers, only: [:new, :create]

    resources :menus, only: [:new, :create, :show] do
      resources :menu_contents, only: [:new, :create, :show, :destroy]
    end

    resources :dishes do
      resources :servings, only: [:new, :create, :edit, :update, :destroy, :index, :show]
      post 'active', on: :member
      post 'inactive', on: :member

    end
    resources :beverages do
      resources :servings, only: [:new, :create, :edit, :update, :destroy, :index, :show]
      post 'active', on: :member
      post 'inactive', on: :member

    end

    resources :orders, only: [:new, :create, :show]

  end
  get 'search', to: 'search#search'

end
