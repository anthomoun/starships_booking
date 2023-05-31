class StarshipsController < ApplicationController
  before_action :set_starship, only: %i[show edit update destroy]

  def index
    @starships = Starship.all
  end

  def show
    @starship = Starship.find(params[:id])
    @booking = Booking.new
  end

  def new
    @starship = Starship.new
  end

  def create
    @starship = Starship.new(starship_params)
    @starship.user = User.all.sample # PROVISOIRE
    if @starship.save
      redirect_to starship_path(@starship), notice: "Your starship is ready to be rent 🚀!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @starship.update(starship_params)
      redirect_to starship_path(@starship), notice: "your starship was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @starship.destroy
    redirect_to starships_url, notice: "your starship was successfully destroyed 💥"
  end

  def location
    @starships = Starship.where("address like ?", params[:location])
  end

  private

  def set_starship
    @starship = Starship.find(params[:id])
  end

  def starship_params
    # params.require(:starship).permit(:name, :starship_type, :number_of_persons, :address, :price, :description, photos: [])
    params.require(:starship).permit(:name, :starship_type, :number_of_persons, :address, :price, :description)
  end
end
