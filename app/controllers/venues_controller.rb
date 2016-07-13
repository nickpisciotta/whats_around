class VenuesController < ApplicationController

  def index
    @venues = Venue.all(current_user)
  end

  def show
    @venue = Venue.find(params[:id])
  end

end
