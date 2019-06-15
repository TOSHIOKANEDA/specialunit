class InquiryMailer < ApplicationMailer
  
  # fromはuser.admin:trueのemailとcurrent_user.email, 追加で送って欲しい人に送るように設定
  
  def send_mail(inquiry)
    @inquiry = inquiry
    mail(
      from: 'system@example.com',
      to:   'manager@example.com',
      subject: 'Specialunitの在庫問い合わせきますた'
    )
  end
  
end
