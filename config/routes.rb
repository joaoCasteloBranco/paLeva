Rails.application.routes.draw do
  devise_for :users
  root "home#index"
  resources :restaurants, only: [:new, :create, :show, :index]
  resources :menu_items, only: [:new, :create]
  resources :restaurants do
    resources :dishes
    resources :beverages
  end
  get 'search', to: 'search#search'

end
