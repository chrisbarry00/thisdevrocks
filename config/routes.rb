Rails.application.routes.draw do
  get "/ping", to: proc { [ 200, {}, [ "Pong" ] ] }

  namespace :api do
    resources :posts, param: :slug, only: [ :index, :show, :create, :update, :destroy ]
  end

  # Health check endpoint for uptime monitoring
  get "up" => "rails/health#show", as: :rails_health_check

  # Root route (optional, can be uncommented if you want a default route)
  # root "api/posts#index"
end
