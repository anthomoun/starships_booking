class DashboardController < ApplicationController

  def index
    if current_user.guest?
      @pending_bookings = current_user.bookings.where(status: 'pending')
    elsif current_user.host?
      @starships = current_user.starships
      @accepted_bookings = current_user.bookings.where(status: 'accepted')
      @refused_bookings = current_user.bookings.where(status: 'refused')
    end
  end
end
