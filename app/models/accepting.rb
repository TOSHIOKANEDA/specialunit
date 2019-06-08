class Accepting < ApplicationRecord
  belongs_to :booking, optional: true
end
