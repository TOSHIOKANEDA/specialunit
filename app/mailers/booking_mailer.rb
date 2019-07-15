class BookingMailer < ApplicationMailer

  
    def send_when_update(booking)
    @booking = booking
   
    
    if booking.status == 'waiting'
    status_update_check = '新規スペコン在庫問い合わせ'
    elsif booking.status =='waiting_list'
    status_update_check = 'キャンセル待ちにしました！'
    elsif booking.status == 'rejected'
    status_update_check = '在庫ありません。'
    elsif booking.status == 'confirmed'
    status_update_check = '在庫あります！確保はこの後に実際Booking入れてからです！'
    end
    
    @status = status_update_check
    
    if booking.status == 'confirmed'

    mail from: ENV['MAIL_ID'],
    to: ENV['MAIL_ID'],
    cc: ["#{admin_email}","#{booking.email}"],
    subject:'[' + booking.tk_number + ']' + booking.email + 'さん / ' + booking.place + 'の' + booking.kind + 'X'+ booking.volume.to_s + 
            'について' + status_update_check
    
    else
    mail from: ENV['MAIL_ID'],
    to: ENV['MAIL_ID'],
    cc: ["#{admin_email}","#{booking.email}"],
    subject: booking.email + 'さん / ' + booking.place + 'の' + booking.kind + 'Ｘ'+ booking.volume.to_s + 
            'について' + status_update_check

    end
    
    
            

    end
    
    
    def send_when_done(booking)
    @booking = booking

    mail from: ENV['MAIL_ID'],
    to: ENV['MAIL_ID'],
    cc: ["#{admin_email}","#{booking.email}","#{booking.sub_column}"],
    subject: booking.email + 'さん / ' + booking.place + '/' + booking.kind + '/ '+ booking.volume.to_s + 
            'についての新規問い合わせ'
    end
    
    
    
    def admin_email
    a = User.find_by(admin: 1)
    @admin_email = a.email
    end
    
    
end
