class DashboardController < ApplicationController

  def index
    @bookings = current_user.bookings
    @starship = current_user.starships.first
    @bookings = current_user.host? ? current_user.bookings.pending : current_user.bookings

    if current_user.guest?
      @pending_bookings = current_user.bookings.where(status: 'pending')
    elsif current_user.host?
      @starships = current_user.starships
      @accepted_bookings = current_user.bookings.where(status: 'accepted')
      @refused_bookings = current_user.bookings.where(status: 'refused')

    end
  end

  def update_booking_status
    booking = Booking.find(params[:id])
    booking.update(status: params[:booking][:status])
    redirect_to dashboard_path, notice: 'Booking status updated successfully.'
  end


end
