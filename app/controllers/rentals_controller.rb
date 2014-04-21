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

  def search

  end

  def index
    # neighborhoods = neighborhood_params[1..-1]  #IS THIS RIGHT??!?!?!?
    @rentals = Rental.where().where().where()
    render :index
  end

  def new
    fail
    @rental = Rental.new
    render :new
  end

  def create
    @rental = Rental.new(rental_params)
    fail

    redirect_to user_url(current_user.id)
  end

  def show

  end

  def destroy

  end

  private
  def rental_search_params
    params.require(:rental).permit(:num_bedrooms, :num_bathrooms, :price_min, :price_max, neighborhoods: [])
  end

  def neighborhood_params
    # params.require(:rental).require(:neighborhoods)
  end

end
