class BookingsController < ApplicationController

  def index
    @bookings = current_user.bookings
  end

  def create

    @booking = Booking.find(params[:booking_id])
    @booking = Booking.new(booking_params)
    @booking.starship = @starship
    @booking.user = current_user
    if @booking.save
      redirect_to starship_path(@starship), notice: "booking have been created succefully!"
    else
      render 'bookings/show'
    end
  end

  private

  def booking_params
    params.require(:booking).permit(:start_date, :end_date, :status)
  end
end
