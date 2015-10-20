Rails.application.routes.draw do
  resources :gps_points, only: [:index, :create, :destroy]
  resources :traces
end
