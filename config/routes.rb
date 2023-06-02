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

  resources :bookings, only: [ :show, :destroy ]
  get 'accept_booking/:id', to: 'dashboard#accept_booking', as: 'accepted_booking'
  get 'refuse_booking', to: 'dashboard#refuse_booking', as: 'refused_booking'

  get 'dashboard', to: 'dashboard#index'
  patch 'dashboard/bookings/:id/update_status', to: 'dashboard#update_booking_status', as: 'update_booking_status'


  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
