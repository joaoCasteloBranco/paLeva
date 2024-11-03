Rails.application.routes.draw do
  devise_for :users
  root "home#index"
  resources :restaurants, only: [:new, :create, :show, :index]


  resources :restaurants do

    resources :operating_days, only: [:new, :create, :update, :edit, :show]

    resources :dishes do
      post 'active', on: :member
      post 'inactive', on: :member
    end
    resources :beverages do
      post 'active', on: :member
      post 'inactive', on: :member
    end

  end
  get 'search', to: 'search#search'

end
