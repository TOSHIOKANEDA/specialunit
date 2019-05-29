Rails.application.routes.draw do
 get   'bookings/new'  =>  'bookings#new'
 post  'bookings'      =>  'bookings#create'
 patch 'bookings/:id' => 'bookings#update'
 delete 'bookings/:id' => 'bookings#destroy', as: 'destroy_booking'
get 'bookings/show' =>  'bookings#show' 
  root 'bookings#index'
  devise_for :users

 
  
end