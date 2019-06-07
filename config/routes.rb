Rails.application.routes.draw do
devise_for :users
 get   'bookings/new'  =>  'bookings#new'
 post  'bookings'      =>  'bookings#create'
 patch 'bookings/:id' => 'bookings#update'
 delete 'bookings/:id' => 'bookings#destroy', as: 'destroy_booking'
get 'bookings/show' =>  'bookings#show' 
  root 'bookings#index'
 get   'acceptings/new'  =>  'acceptings#new'
 post  'acceptings'      =>  'acceptings#create'
 
  
end