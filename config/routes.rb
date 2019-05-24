Rails.application.routes.draw do
 get   'bookings/new'  =>  'bookings#new'
 post  'bookings'      =>  'bookings#create'
 patch 'bookings/:id' => 'bookings#update'
  root 'bookings#index'
  devise_for :users
 
  
end