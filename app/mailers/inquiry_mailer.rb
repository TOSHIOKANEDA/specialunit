class InquiryMailer < ApplicationMailer
  
  # fromはuser.admin:trueのemailとcurrent_user.email, 追加で送って欲しい人に送るように設定
  
  def send_when_update(booking)
    @booking = booking
    mail(
      from: 'camp1of1tech@gmail.com',
      to:   'camp1of1tech@gmail.com',
      subject: 'Specialunitの在庫問い合わせきますた'
    )
  end
  
end
