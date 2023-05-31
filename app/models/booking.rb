class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :starship

  validates :start_date, :end_date, presence: true
  validate :end_date_after_start_date
  validate :validate_availability

  private

  def end_date_after_start_date
    return if end_date.blank? || start_date.blank?

    if end_date < start_date
      errors.add(:end_date, "must be after the start date")
    end
  end


  def validate_availability
    bookings = Booking.where(starship_id: starship_id)
    date_ranges = bookings.pluck(:start_date, :end_date)

    date_ranges.each do |range|
      if range[0] < start_date && range[1] > start_date
        errors.add(:start_date, "is not available")
        return
      end
    end
  end


end
