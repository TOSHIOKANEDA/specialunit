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
      @a_day_behind_accepting = Accepting.where('kind=? and place=? and week=?', @booking.kind, @booking.place, (@booking.week + 1))
      @a_day_ahead_accepting = Accepting.where('kind=? and place=? and week=?', @booking.kind, @booking.place, (@booking.week - 1))
      
      no = "ダメ"
      yes = "今のところOKそうなんで、申請進めてください"
      no_idea = "連休だからわかんないです。とりあえず申請してください"
      
        if @booking.week == 1 || 2
          @accepting_result = no_idea
          # @a_day_ahead_accepting_result = no_idea
          # @a_day_behind_accepting_result = no_idea
          elsif @accepting.exists?
          @accepting_result = no
        else
          @accepting_result = yes
        end
        # elsif @accepting.exists?
        #   @accepting_result = no
        #   else
        #   @accepting_result = yes
        # elsif @a_day_behind_accepting.exists?
        #   @a_day_behind_accepting_result = no
        #   else
        #   @a_day_behind_accepting_result = yes
        # end
        
  
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
