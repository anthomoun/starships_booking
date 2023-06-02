class DashboardController < ApplicationController

  def index
    @bookings = current_user.bookings


  if current_user.host?
  @starships = current_user.starships

  @requests = []
    @starships.each do  |s|
        s.bookings.each do |b|
          @requests << b if b.status == 'pending'
        end
      end
    end
  end

  def update_booking_status
    booking = Booking.find(params[:id])
    booking.update(status: params[:booking][:status])
    redirect_to dashboard_path, notice: 'Booking status updated successfully.'
  end

  def accept_booking
    @booking = Booking.find(params[:id])
    @booking.status = 'accepted'
    @booking.save
    redirect_to dashboard_path, notice: 'Booking status updated successfully.'

  end

  def refuse_booking
    @booking = Booking.find(params[:id])
    @booking.status = 'refused'
    @booking.save
    redirect_to dashboard_path, notice: 'Booking status updated successfully.'
  end


end
