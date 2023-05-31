class BookingsController < ApplicationController

  def index
    @bookings = current_user.bookings
  end

  def create
    @starship = Starship.find(params[:starship_id])
    @booking = Booking.new(booking_params)
    @booking.starship = @starship
    @booking.user = current_user
    if @booking.save
      redirect_to starship_path(@starship), notice: "Booked Successfully!"
    else

      # render 'starships/show', starship: @starship
    end
  end


  private

  def booking_params
    params.require(:booking).permit(:start_date, :end_date, :status)
  end
end
