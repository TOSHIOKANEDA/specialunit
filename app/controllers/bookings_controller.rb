class BookingsController < ApplicationController

before_action :move_to_index, except: :index

def index
end

def admin
redirect_to action: :index if current_user.admin.blank?
@users = User.all
end

def seek_booking
end

def seek_booking_result
      @w_place = booking_params[:place]
      @w_kind = booking_params[:kind]
      @w_week = booking_params[:week]
      
      
  
      @booking = Booking.where(place: @w_place, kind: @w_kind, week: @w_week)  
      @a = Accepting.where(place: @w_place, kind: @w_kind, week: @w_week)  
      @pre_booking = Booking.where(place: @w_place, kind: @w_kind, week: @w_week).pluck(:volume).compact.inject(:+)
      @a_day_behind = Accepting.where('kind=? and place=? and week=?', @w_kind, @w_place, (@w_week.to_i + 1))
      @a_day_ahead = Accepting.where('kind=? and place=? and week=?', @w_kind, @w_place, (@w_week.to_i - 1))
      no = "在庫薄"
      yes = "良好"
      no_idea = "良好（年末年始期間ターミナルと要確認）"
      ban_week = booking_params[:week] == 1 || booking_params[:week]== 2 || booking_params[:week] == 52

        if @a.present?
          @a_result = no
          else
            @a_result = yes unless ban_week
            @a_result = no_idea if ban_week
        end
        
        if @a_day_behind.present?
          @a_day_behind_result = no
          else
            @a_day_behind_result = yes unless ban_week
            @a_day_behind_result = no_idea if ban_week
        end
        
        if @a_day_ahead.present?
          @a_day_ahead_result = no
          else
            @a_day_ahead_result = yes unless ban_week
            @a_day_ahead_result = no_idea if ban_week
        end
        
    if @pre_booking.blank?
          @pre_booking_result = "なし"
          else
            if @pre_booking > 0
              @pre_booking_result = "#{@pre_booking}本"
            else
              @pre_booking_result = "なし"
            end
    end
end

def search
  redirect_to action: :index if current_user.admin.blank?
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
  redirect_to({action: 'search'}, alert: "その条件ではなし！") if @results.blank?
  
end

def edit
  @booking = Booking.find(params[:id])
end


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

def new
    @w_place = booking_params[:place]
    @w_kind = booking_params[:kind]
    @w_week = booking_params[:week]
    @booking = Booking.new
end
 
def confirm
    @booking = Booking.new(create_params)
    render :action => 'confirm'
end
 
def done
  @booking = Booking.new(create_params)
  if params[:back]
      render :action => 'new'
  else
      @booking.save
      BookingMailer.send_when_done(@booking).deliver_now
      render :action => 'done'
  end
end

private
def booking_params
  params.permit(:place, :kind, :week, :volume, :status, :year, :sub_column, :main_column, :email, :admin, :tk_number)
end

def create_params
  params.require(:booking).permit(:place, :kind, :week, :volume, :status, :year, :sub_column, :main_column, :email, :tk_number)
end

def move_to_index
    redirect_to action: :index unless user_signed_in?
end

end

