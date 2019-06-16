# Preview all emails at http://localhost:3000/rails/mailers/booking_mailer
class BookingMailerPreview < ActionMailer::Preview
  def booking
     booking = Booking.find(id:1)
    
     BookingMailer.send_when_update(booking)
  end

end
