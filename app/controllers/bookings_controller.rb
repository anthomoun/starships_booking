class BookingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_default_status, on: :create

  def index
    @bookings = current_user.bookings
    @bookings = current_user.host? ? current_user.bookings.pending : current_user.bookings
    raise
  end

  def edit
    @booking = Booking.find(params[:id])
    @starship = Starship.find(params[:starship_id])
  end

  def show
    @starship = Starship.find(params[:starship_id])
    @booking = Booking.find(params[:id])
  end


  def create
    @starship = Starship.find(params[:starship_id])
    @booking = @starship.bookings.new(booking_params)
    @booking.status = 'pending'
    @booking.starship = @starship
    @booking.user = current_user
    if @booking.save
      redirect_to starship_path(@starship), notice: "Booked Successfully!"
    else
      puts @booking.errors.full_messages # Output errors to console

      # render 'starships/show', starship: @starship
    end
  end



  def destroy
    @booking = Booking.find(params[:id])
    @booking.destroy
    redirect_to dashboard_path, notice: 'Booking was successfully cancelled.'
  end



  private

  def set_default_status
    self.status = 'pending' if self.status.nil?
  end


  def booking_params
    params.require(:booking).permit(:start_date, :end_date, :status)
  end
end
