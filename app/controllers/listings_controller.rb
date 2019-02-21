class ListingsController < ApplicationController
  def index
    @listings = Listing.all

    @listings = @listings.where("lower(location_name) LIKE ?", "%#{params[:location_name].downcase}%") if params[:location_name]
  end

  def new
    @listing = Listing.new
  end

  def create
    @listing = Listing.new(listing_params)
    @listing.user_id = current_user.id

    if @listing.save
      flash[:success] = "Listing created"
    else
      flash[:error] =  "Listing creation fail. #{@listing.errors.full_messages}"
    end
      redirect_to root_path

  end

  def show
    @listing = Listing.find(params[:id])
  end

  private

  def listing_params
    params.require(:listing).permit(:location_name, :address, :email, :phone_number, :ratings, :user_id)
  end
  
end
