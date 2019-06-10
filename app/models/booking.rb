class Booking < ApplicationRecord
  has_one :accepting
  
# def self.search(search)
#       return Booking.all unless search
#       Booking.where(['place ?', "%#{place}%"])
# end

end
