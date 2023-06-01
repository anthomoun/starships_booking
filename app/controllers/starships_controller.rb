class StarshipsController < ApplicationController
  before_action :set_starship, only: %i[show edit update destroy]



  def index
    @starships = Starship.all
    @markers = @starships.geocoded.map do |starship|
      {
        lat: starship.latitude,
        lng: starship.longitude,
        info_window_html: render_to_string(partial: "info_window", locals: {starship: starship}),
        marker_html: render_to_string(partial: "marker")
      }
    end
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
    @starship.user = current_user
    if @starship.save
      redirect_to starship_path(@starship), notice: "Your starship is ready to be rent 🚀!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
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
    redirect_to starships_path, notice: "your starship was successfully destroyed 💥"
  end

  def location
    if params[:query].present?
      @starships = Starship.where("address ILIKE ?", "%#{params[:query]}%")
    else
      @starships = Starship.all
    end
  end

  private

  def set_starship
    @starship = Starship.find(params[:id])
  end

  def starship_params
    params.require(:starship).permit(:name, :starship_type, :number_of_persons, :address, :price, :description, photos: [])
  end
end
