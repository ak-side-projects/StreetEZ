class RentalsController < ApplicationController

  def home
    @rentals = Rental.all

    @rental_ex1 = @rentals.sample
    until !@rental_ex2.nil? && @rental_ex2 != @rental_ex1 do
      @rental_ex2 = @rentals.sample
    end
    until !@rental_ex3.nil? && (@rental_ex3 != @rental_ex1 && @rental_ex3 != @rental_ex2) do
      @rental_ex3 = @rentals.sample
    end

    render :home
  end

  def index
    @rentals = Rental.all
    if params[:rental]
      if rental_search_params[:num_bedrooms].present?
        num_bedrooms = rental_search_params[:num_bedrooms].to_i
        @rentals = @rentals.where(num_bedrooms: num_bedrooms)
      end

      if rental_search_params[:num_bathrooms].present?
        num_bathrooms = rental_search_params[:num_bathrooms].to_i
        @rentals = @rentals.where(num_bathrooms: num_bathrooms)
      end

      if rental_search_params[:neighborhoods].present?
        @rentals = @rentals.where(neighborhood: rental_search_params[:neighborhoods])
      end

      if rental_search_params[:price_min].present?
        price_min = rental_search_params[:price_min].to_i
      else
        price_min = 0
      end

      if rental_search_params[:price_max].present?
        price_max = rental_search_params[:price_max].to_i
      else
        price_max = Rental.all.order(monthly_rent: :desc).first.monthly_rent
      end
      @rentals = @rentals.where(monthly_rent: price_min..price_max)
    end

    render :index
  end

  def new
    @rental = Rental.new
    @rental.build_address()
    render :new
  end

  def create
    @rental = current_user.owned_rentals.new(rental_params)
    @rental.build_address(address_params)

    photo_params.each do |file_params|
      @rental.photos.new(file: file_params)
    end

    if @rental.save
      redirect_to user_url(current_user.id)
    else
      flash.now[:errors] = @rental.errors.full_messages
      render :new
    end
  end

  def show
    @rental = Rental.find_by(id: params[:id])
    render :show
  end

  def edit
    @rental = Rental.find_by(id: params[:id])
    render :edit
  end

  def update
    @rental = Rental.find(params[:id])

    photo_params.each do |file_params|
      @rental.photos.new(file: file_params)
    end

    if @rental.update(rental_params) && @rental.address.update(address_params)
      redirect_to rental_url(@rental.id)
    else
      flash.now[:errors] = @rental.errors.full_messages
      render :edit
    end
  end

  def destroy
    @rental = Rental.find(params[:id])
    @rental.destroy
    redirect_to user_url(current_user.id)
  end

  private
  def rental_search_params
    params.require(:rental).permit(:num_bedrooms, :num_bathrooms, :price_min, :price_max, neighborhoods: [])
  end

  def rental_params
    params.require(:rental).permit(:neighborhood, :num_bedrooms, :num_bathrooms, :monthly_rent, :sq_footage)
  end

  def address_params
    params.require(:address).permit(:street, :unit, :city, :state, :zipcode)
  end

  def photo_params
    params.require(:photos)
  end
end
