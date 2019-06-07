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
      @a = Accepting.where('kind=? and place=? and week=?', @booking.kind, @booking.place, @booking.week)
      @pre_booking = Booking.where("place=? and kind=? and week=?", @booking.place, @booking.kind, @booking.week).pluck(:volume).compact.inject(:+)
      @a_day_behind = Accepting.where('kind=? and place=? and week=?', @booking.kind, @booking.place, (@booking.week + 1))
      @a_day_ahead = Accepting.where('kind=? and place=? and week=?', @booking.kind, @booking.place, (@booking.week - 1))
      no = "ダメ"
      yes = "今のところOKそうなんで、申請進めてください"
      no_idea = "年末年始っすよ。在庫確認する前にターミナルに受けれるのか確認"
      
        if @a.exists?
          @a_result = no
        else
          @a_result = yes unless @booking.week == 1 || @booking.week == 2 || @booking.week == 51 || @booking.week == 52
          @a_result = no_idea if @booking.week == 1 || @booking.week == 2 || @booking.week == 51 || @booking.week == 52
        end
        
        if @a_day_behind.exists?
          @a_day_behind_result = no
        else
          @a_day_behind_result = yes unless @booking.week == 1 || @booking.week == 2 || @booking.week == 51 || @booking.week == 52
          @a_day_behind_result = no_idea if @booking.week == 1 || @booking.week == 2 || @booking.week == 51 || @booking.week == 52
        end
        
        if @a_day_ahead.exists?
          @a_day_ahead_result = no
        else
          @a_day_ahead_result = yes unless @booking.week == 1 || @booking.week == 2 || @booking.week == 51 || @booking.week == 52
          @a_day_ahead_result = no_idea if @booking.week == 1 || @booking.week == 2 || @booking.week == 51 || @booking.week == 52
        end
        
        if @pre_booking.blank?
          @pre_booking_result = "引き合いないっすよ。よかったね。"
          else
            if @pre_booking > 0
              @pre_booking_result = "ところで#{@pre_booking}本の引き合いがあります。"
            else
              @pre_booking_result = "引き合いないっすよ。よかったね。"
            end
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
  params.permit(:place, :kind, :week, :sub_column, :main_column, :volume, :email, :status, :year)
end

end
