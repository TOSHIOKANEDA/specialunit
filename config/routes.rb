Rails.application.routes.draw do
devise_for :users
 get   'bookings/new'  =>  'bookings#new'
 post  'bookings/confirm'  =>  'bookings#confirm'
 post  'bookings/done' =>  'bookings#done'
 patch 'bookings/:id' => 'bookings#update'
  root 'bookings#index'
 get   'acceptings/new'  =>  'acceptings#new'
delete 'acceptings/:id' => 'acceptings#destroy'
 post  'acceptings'      =>  'acceptings#create'
 get 'acceptings/show' =>  'acceptings#show' 
 get   'bookings/search'  =>  'bookings#search'
 get   'bookings/result'  =>  'bookings#result'
patch 'bookings/:id/edit' => 'bookings#edit'
  get 'bookings/:id/edit' =>  'bookings#search'
  devise_scope :user do
  get '/users/sign_out' => 'devise/sessions#destroy'
  get 'bookings/admin'  =>  'bookings#admin'
  get 'users/:id/edit'  =>  'users/sessions#edit'
  patch 'users/:id/edit' => 'users/sessions#update'
  delete 'users/:id' => 'users/sessions#destroy', as: 'destroy_session_user'
  get 'users/:id'  =>  'users/sessions#destroy'
  get 'bookings/seek_booking_result' => 'bookings#seek_booking_result'
  # delete 'bookings/:id' => 'bookings#destroy', as: 'destroy_booking'
 

  
  end
  
end