Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Defines the root path route ("/")
  post '/', to: "sudokus#index"
  root "sudokus#index"
end
