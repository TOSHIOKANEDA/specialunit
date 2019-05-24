class BookingsController < ApplicationController

def index
  @booking = Booking.all
end

def new
end

def create
  Booking.create(booking_params)
  @booking = Booking.all
end

def create
  booking = Booking.new(booking_params)
  if booking.save
    @booking = Booking.order("id DESC").first
  else
    redirect_to action: 'index', alert: '投稿できませんでした。'
  end
end

# def confirm
#   @booking = Booking.new(kind: params[:kind], place: params[:place], week:[:week])
#   return if @booking.valid?
#   render :new
# end

# def back
#   @booking = Booking.new(kind: params[:kind], place: params[:place], week:[:week])
#   render :new
# end

# def create
#   Booking.create(kind: params[:kind], place: params[:place], week:[:week])
#   render :complete
# end

private
def booking_params
  params.permit(:place, :kind, :week)
end

end
