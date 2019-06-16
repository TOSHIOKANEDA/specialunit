# Preview all emails at http://localhost:3000/rails/mailers/inquiry_mailer
class InquiryMailerPreview < ActionMailer::Preview


  def booking
     booking = Booking.find(id:1)
    
     InquiryMailer.send_when_update(booking)
  end

end
