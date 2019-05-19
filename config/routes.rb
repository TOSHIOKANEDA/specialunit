Rails.application.routes.draw do
  devise_for :users
  get 'bookings' => 'bookings#index'
end
