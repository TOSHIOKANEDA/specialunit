class BookingMailer < ApplicationMailer
  
    def send_when_update(booking)
    @booking = booking
    mail from: '',to: '',subject: 'Specialunitの在庫問い合わせきますた'　<=ここGIT用に消した！Gmailアドレス
    end
  
end
