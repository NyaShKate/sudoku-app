Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Defines the root path route ("/")
  post '/enter', to: "sudokus#enter"
  post '/', to: "sudokus#index"
  post '/solve', to: "sudokus#solver"
  post '/gen', to: "sudokus#generate"
  root "sudokus#index"
end
