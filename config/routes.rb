Rails.application.routes.draw do
  # Define the root path route ("/")
  root "home#index"

  # Employee management routes (example resource)
  resources :employees, :projects, :vehicles, :assignments
  
  # Health check route for monitoring
  get "up" => "rails/health#show", as: :rails_health_check
end
