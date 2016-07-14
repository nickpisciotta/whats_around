Rails.application.routes.draw do

  root "homes#show"

  get "auth/foursquare", as: :foursquare_login
  get "auth/foursquare/callback", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  get "/venues/search", to: 'venues#search'

  resources :venues, only: [:index, :show]

  resources :users, only: [:show]

end
