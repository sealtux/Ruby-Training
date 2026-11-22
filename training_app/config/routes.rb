Rails.application.routes.draw do
  root "tasks#index"
  resources :tasks do
    resources :comments, only: [:create, :destroy] if ENV.fetch("TRAINING_DAY", "6").to_i >= 8
  end
  resources :events if ENV.fetch("TRAINING_DAY", "6").to_i >= 10
  if ENV.fetch("TRAINING_DAY", "6").to_i >= 9
    get "/signup", to: "sessions#new_registration"
    post "/signup", to: "sessions#register"
    get "/login", to: "sessions#new"
    post "/login", to: "sessions#create"
    delete "/logout", to: "sessions#destroy"
  end
end
