Rails.application.routes.draw do
devise_for :users
 get   'bookings/new'  =>  'bookings#new'
 post  'bookings'      =>  'bookings#create'
 patch 'bookings/:id' => 'bookings#update'
 delete 'bookings/:id' => 'bookings#destroy', as: 'destroy_booking'
get 'bookings/show_prebookers' =>  'bookings#show_prebookers' 
  root 'bookings#index'
 get   'acceptings/new'  =>  'acceptings#new'
 post  'acceptings'      =>  'acceptings#create'
 get 'acceptings/show' =>  'acceptings#show' 
 get   'bookings/search'  =>  'bookings#search'
 get   'bookings/result'  =>  'bookings#result'

  
end