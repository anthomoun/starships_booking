class AvailabilityValidator < ActiveModel::EachValidator

  def validate_each(record, attribute, value)
    bookings = Booking.where(["starship_id =?", record.starship_id])
    date_ranges = bookings.map { |b| [b.start_date, b.end_date] }

    date_ranges.each do |range|
      if range[0] < value && range[1] > value
        record.errors.add(attribute, "not available")
        return
      end
    end
  end
end
