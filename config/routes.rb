Rails.application.routes.draw do
  devise_for :users
  root "home#index"
  resources :restaurants, only: [:new, :create, :show, :index]


  resources :restaurants do

    resources :operating_days, only: [:new, :create, :update, :edit, :show]

    resources :dishes
    resources :beverages
  end
  get 'search', to: 'search#search'

end
