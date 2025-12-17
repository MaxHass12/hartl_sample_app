Rails.application.routes.draw do
  get "sessions/new"
  root "static_pages#home"

  # static pages
  get "/help", to: "static_pages#help"
  get "/about", to: "static_pages#about"
  get "/contact", to: "static_pages#contact"

  # signup
  get "/signup", to: "users#new"

  # login
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  resources :users
end
