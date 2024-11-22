Rails.application.routes.draw do
  devise_for :employees, path: 'employees', controllers: {
    sessions: 'employees/sessions',
    registrations: 'employees/registrations'
  }
  devise_for :users

  root "home#index"
  get '/orders/status', to: 'orders#status'
  post '/orders/check', to: 'orders#check'

  resources :restaurants do

    resources :employees, only: [:index, :new, :create, :destroy]

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

    resources :orders, only: [:new, :create, :show, :index] do
      post 'close_order', on: :member
      get 'result', on: :member
      resources :order_items, only: [:new, :create]
    end

    resources :discounts do
      resources :discount_servings, only: [:new, :create]
    end

  end
  get 'search', to: 'search#search'

  namespace :api do
    namespace :v1 do
      resources :restaurants do
        resources :orders, only: [:show, :index] do
          post 'in_preparation', on: :member
          post 'ready', on: :member
          post 'canceled', on: :member
        end
      end
    end
  end
end
