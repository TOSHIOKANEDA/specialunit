class BookingsController < ApplicationController

def index
  @booking = Booking.all
end

def new
end

def create
  Booking.create(booking_params)
end

def create
  booking = Booking.new(booking_params)
  if booking.save
    @booking = Booking.order("id DESC").first
  else
    redirect_to action: 'index', alert: '投稿できませんでした。'
  end
end

def update
  booking = Booking.find(params[:id])
  booking.update(booking_params)
end

def destroy
  @booking = Booking.find(params[:id])
  @booking.destroy
  redirect_to action: 'new'
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
  params.permit(:place, :kind, :week, :sub_column, :main_column, :volume, :email)
end

end
