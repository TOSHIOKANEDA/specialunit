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
      @accepting = Accepting.where('kind=? and place=? and week=?', @booking.kind, @booking.place, @booking.week)
      @pre_booking = Booking.where("place=? and kind=? and week=?", @booking.place, @booking.kind, @booking.week).pluck(:volume).compact.inject(:+)
      
        if @accepting.exists?
          @accepting_result = "ダメ"
        else
          @accepting_result = "今のところOKそうなんで、申請進めてください"
        end
        
        if @pre_booking > 0
          @pre_booking_result = "ところで#{@pre_booking}本の引き合いがあります。"
        else
          @pre_booking_result = "引き合いないっすよ。よかったね。"
        end
        
    else
    redirect_to action: 'index', alert: '投稿できませんでした。'
    end
end

def show
  @booking = Booking.find_by(id: params[:format])
  @booking.destroy
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

private
def booking_params
  params.permit(:place, :kind, :week, :sub_column, :main_column, :volume, :email)
end

end
