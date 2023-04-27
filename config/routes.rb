Rails.application.routes.draw do
  root "sudokus#index"
  get "/sudokus", to: "sudokus#index"

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
