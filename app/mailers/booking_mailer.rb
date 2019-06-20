class BookingMailer < ApplicationMailer

  
    def send_when_update(booking)
    @booking = booking
   
    
    if booking.status == 'waiting'
    status_update_check = '新規スペコン在庫問い合わせ'
    @status
    elsif booking.status =='waiting_list'
    status_update_check = 'キャンセル待ちにしました！'
    @status
    elsif booking.status == 'rejected'
    status_update_check = '在庫ありません。'
    @status
    elsif booking.status == 'confirmed'
    status_update_check = '在庫の確認がとれました！'
    @status
    end
    
     @status = status_update_check

    mail from: '"TK在庫確認だぉ" <????????h@gmail.com>',
    to: '??????@gmail.com',
    reply_to: '????????@hotmail.com',
    subject: "[" + booking.tk_number + "]" + booking.email + 'さん / ' + booking.place + '/' + booking.kind + '/ '+ booking.volume.to_s + 
            'について' + status_update_check + admin_email
    
    
    end
    
    def admin_email
    a = User.find_by(admin: 1)
    @admin_email = a.email
    end
    
end
