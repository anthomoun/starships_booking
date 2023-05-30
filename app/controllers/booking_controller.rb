class BookingsController < ApplicationController
  def create
    @booking = Booking.find(params[:booking_id])
    @booking = Booking.new(booking_params)
    @booking.booking = @booking
    @booking.user = current_user
    if @booking.save
      redirect_to bookings_path
    else
      render 'bookings/show'
    end
  end

  private

  def booking_params
    params.require(:booking).permit(:start_date, :end_date, :status)
  end
end
