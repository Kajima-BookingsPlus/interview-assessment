Rails.application.routes.draw do
  resources :confirmations
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  post "/api/v1/bookings/:id/confirm", to: "confirmation#confirm" , as: :confirm
end
