Rails.application.routes.draw do
  get 'dashboard/index'
  devise_for :users
  root to: "pages#home"
  # root to: "starships#index"

  resources :starships do
    resources :bookings, only: [ :new, :create]
    collection do
      get :location
    end
  end

  resources :bookings, only: [ :show ]
  get 'dashboard', to: 'dashboard#index'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
