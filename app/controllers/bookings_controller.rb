class BookingsController < ApplicationController

before_action :move_to_index, except: :index

def index
end

def admin
redirect_to action: :index if current_user.admin.blank?
@users = User.paginate(page: params[:page], per_page: 10)
@non_login_users = @users.reject{|user| user.id == current_user.id }

end

def seek_booking
end

def seek_booking_result
      @w_place = booking_params[:place]
      @w_kind = booking_params[:kind]
      @w_week = booking_params[:week][-2..-1]
      @w_year = booking_params[:week][0..3]
      @w_ot_20 = booking_params[:ot_20]
      @w_ot_40 = booking_params[:ot_40]
      @w_fr_20 = booking_params[:fr_20]
      @w_fr_40 = booking_params[:fr_40]

      
      @booking = Booking.where(place: @w_place).where(week: @w_week)
      
      @a = Accepting.where(place: @w_place, kind: @w_kind, week: @w_week)
      @a_day_behind = Accepting.where('kind=? and place=? and week=?', @w_kind, @w_place, (@w_week.to_i + 1))
      @a_day_ahead = Accepting.where('kind=? and place=? and week=?', @w_kind, @w_place, (@w_week.to_i - 1))
      no = "在庫薄！"
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

end

def search
  redirect_to action: :index if current_user.admin.blank?
end


def result
  a = params[:place]
  b = params[:year]
  c = params[:week]
  d = params[:status]
  
  place_condition = Booking.where(place: a).where(status: d).paginate(page: params[:page], per_page: 10)
  year_condition = Booking.where(year: b).where(status: d).paginate(page: params[:page], per_page: 10)
  all_condition = Booking.where(place: a).where(year: b).where(week: c).where(status: d).paginate(page: params[:page], per_page: 10)
  status_condition = Booking.where(status: d).paginate(page: params[:page], per_page: 10)
  week_condition = Booking.where(week: c).where(status: d).paginate(page: params[:page], per_page: 10)
  
if a.present?
    if b.present?
      if c.present?
      @results = all_condition
      else
      @results = place_condition.where(year: b)
      end
    elsif c.present?
      @results = place_condition.where(week: c)
    else
      @results = place_condition
    end
    
elsif b.present?
    if c.present?
    @results = week_condition.where(year: b)
    else
    @results = year_condition
    end
    
elsif c.present?
    @results = week_condition
    
else
    @results = status_condition
end
  redirect_to({action: 'search'}, alert: "その条件ではなし！") if @results.blank?
end




def downdload
  a = params[:place]
  b = params[:year]
  c = params[:week]
  d = params[:status]
  
  place_condition = Booking.where(place: a).where(status: d)
  year_condition = Booking.where(year: b).where(status: d)
  all_condition = Booking.where(place: a).where(year: b).where(week: c).where(status: d)
  status_condition = Booking.where(status: d)
  week_condition = Booking.where(week: c).where(status: d)
  

  if a.present?
    if b.present?
      if c.present?
      @results = all_condition
      respond_to do |format|
      format.html
      format.xlsx {response.headers['Content-Disposition'] = 'attachment; filename="Product.xlsx"'}
      end
      else
      @results = place_condition.where(year: b)
      respond_to do |format|
      format.html
      format.xlsx {response.headers['Content-Disposition'] = 'attachment; filename="Product.xlsx"'}
      end
      end
    elsif c.present?
      @results = place_condition.where(week: c)
      respond_to do |format|
      format.html
      format.xlsx {response.headers['Content-Disposition'] = 'attachment; filename="Product.xlsx"'}
      end
    else
      @results = place_condition
      respond_to do |format|
      format.html
      format.xlsx {response.headers['Content-Disposition'] = 'attachment; filename="Product.xlsx"'}
      end
    end
      
  else
    if b.present?
      if c.present?
    else
      @results = year_condition
      respond_to do |format|
      format.html
      format.xlsx {response.headers['Content-Disposition'] = 'attachment; filename="Product.xlsx"'}
      end
      end
    elsif c.present?
    @results = week_condition
    respond_to do |format|
    format.html
    format.xlsx {response.headers['Content-Disposition'] = 'attachment; filename="Product.xlsx"'}
    end
    else
    @results = status_condition
    respond_to do |format|
    format.html
    format.xlsx {response.headers['Content-Disposition'] = 'attachment; filename="Product.xlsx"'}
    end
    end
  end
  
  
    Axlsx::Package.new do |p|
    p.workbook.add_worksheet(name: "一覧") do |sheet|
      sheet.add_row ["ステータス","申請日","TK番号","港","20OT","40OT","20FR","40FR","WEEK","YEAR","コンテナタイプ","名前","リマーク","許可日"]
      @results.each do |ddl|
      if ddl.status == "confirmed"
      sheet.add_row [ddl.status, ddl.created_at.strftime('%Y年%m月%d日'), ddl.tk_number, ddl.place, ddl.ot_20, ddl.ot_40, ddl.fr_20, ddl.fr_40, ddl.week, ddl.year, ddl.email, ddl.main_column,ddl.updated_at.strftime('%Y年%m月%d日')]
      else
      sheet.add_row [ddl.status, ddl.created_at.strftime('%Y年%m月%d日'), ddl.tk_number, ddl.place, ddl.ot_20, ddl.ot_40, ddl.fr_20, ddl.fr_40, ddl.week, ddl.year, ddl.email, ddl.main_column]
      end
      end
    end
    send_data(p.to_stream.read,
              type: "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",
              filename: "TKダウンロード.xlsx")
  end
  
  
  
end


def edit
  @booking = Booking.find(params[:id])
end


def update
  booking = Booking.find(params[:id])
  booking.update(booking_params)
  BookingMailer.send_when_update(booking).deliver_now
end

def new
    @w_place = booking_params[:place]
    @w_week = booking_params[:week]
    @w_year = booking_params[:year]
    @w_ot_20 = booking_params[:ot_20]
    @w_ot_40 = booking_params[:ot_40]
    @w_fr_20 = booking_params[:fr_20]
    @w_fr_40 = booking_params[:fr_40]
    @booking = Booking.new
end
 

 
 
def confirm
    @booking = Booking.new(create_params)
    @ketsu = create_params[:week][-2..-1]
    @booking.week = @ketsu
    @booking.year = create_params[:week][0..3]  if @booking.year.blank?
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
  params.permit(:place, :kind, :status, :year, :sub_column, :main_column, :email, :admin, :tk_number, :eqc_column, :pick_up, :ot_20, :ot_40, :fr_20, :fr_40, :week, :volume)
end

def create_params
  params.require(:booking).permit(:place, :kind, :status, :year, :sub_column, :main_column, :email, :tk_number, :eqc_column, :pick_up, :ot_20, :ot_40, :fr_20, :fr_40, :week, :volume)
end

def move_to_index
    redirect_to action: :index unless user_signed_in?
end

end

