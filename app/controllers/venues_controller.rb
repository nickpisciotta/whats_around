class VenuesController < ApplicationController

  def index
    @venues = Venue.all(current_user)
  end

  def show
    @venue = Venue.find(current_user, params[:id])
  end

  def search
    @category = Venue.categories(current_user)
    if params[:category]
      @venues_category = Venue.search_location_category(current_user)
      @venues = Venue.search_location(current_user, params[:city], params[:state])
    else
      @venues = Venue.search_location(current_user, params[:city], params[:state])
    end
  end

end
