Rails.application.routes.draw do
 get   'bookings/new'  =>  'bookings#new'
 post  'bookings'      =>  'bookings#create'
  root 'bookings#index'
  devise_for :users
 
  
end