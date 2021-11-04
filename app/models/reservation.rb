class Reservation < ApplicationRecord
  belongs_to :guest

  validates :code, presence: true, uniqueness: true
  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :nights, presence: true, length: { minimum: 1 }
  validates :guests, presence: true, length: { minimum: 1 }
  validates :adults, presence: true, length: { minimum: 1 }

  validates_datetime :start_at, after: :now, after_message: 'Must not be in the past'
  validates_datetime :end_date, after: :start_date, after_message: 'must be after start at date'
end
