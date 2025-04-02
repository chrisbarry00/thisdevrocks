Rails.application.routes.draw do
  namespace :api do
    resources :posts, only: [ :index, :show, :create, :update, :destroy ]
  end

  # Health check endpoint for uptime monitoring
  get "up" => "rails/health#show", as: :rails_health_check

  # Root route (optional, can be uncommented if you want a default route)
  # root "api/posts#index"
end
