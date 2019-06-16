class BookingsController < ApplicationController

before_action :move_to_index, except: :index

def index
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
      no = "ダメそうっすけど、とりあえず進めてください"
      yes = "今のところOKそうなんで、申請進めてください"
      no_idea = "年末年始っすけど、ターミナルの受け入れ大丈夫っすかー？"
      ban_week = @booking.week == 1 || @booking.week == 2 || @booking.week == 52
      
        if @a.exists?
          @a_result = no
        else
          @a_result = yes unless ban_week
          @a_result = no_idea if ban_week
        end
        
        if @a_day_behind.exists?
          @a_day_behind_result = no
        else
          @a_day_behind_result = yes unless ban_week
          @a_day_behind_result = no_idea if ban_week
        end
        
        if @a_day_ahead.exists?
          @a_day_ahead_result = no
        else
          @a_day_ahead_result = yes unless ban_week
          @a_day_ahead_result = no_idea if ban_week
        end
        
        
        d = Date.today
        @year = d.year
        
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

def show_prebookers
  @booking = Booking.find_by(id: params[:format])
  @booking.destroy
end

def search  
end


def result
  a = params[:place]
  b = params[:kind]
  c = params[:week]
  d = params[:status]
  
  place_condition = Booking.where(place: a).where(status: d)
  kind_condition = Booking.where(kind: b).where(status: d)
  all_condition = Booking.where(place: a).where(kind: b).where(week: c).where(status: d)
  status_condition = Booking.where(status: d)
  week_condition = Booking.where(week: c)

if a.present?
  if b.present?
    if c.present?
    @results = all_condition
    else
    @results = place_condition.where(kind: b)
    end
  elsif c.present?
    @results = place_condition.where(week: c)
  else
    @results = place_condition
  end
    
else
  if b.present?
    @results = kind_condition
  elsif c.present?
    @results = week_condition
  else
    @results = status_condition
  end
end
redirect_to action: 'search', alert: 'その条件でのデータは無いです' if @results.blank? 
end

def edit
  @booking = Booking.find(params[:id])
end

# 0616追記！InquiryMailer.send_when_signup(@booking).deliver

def update
  booking = Booking.find(params[:id])
  booking.update(booking_params)
  BookingMailer.send_when_update(booking).deliver_now
end

def destroy
  @booking = Booking.find(params[:id])
  @booking.destroy
  redirect_to action: 'new'
end

private
def booking_params
  params.permit(:place, :kind, :week, :volume, :status, :year, :sub_column, :main_column, :email)
end

  def move_to_index
    redirect_to action: :index unless user_signed_in?
  end

end

