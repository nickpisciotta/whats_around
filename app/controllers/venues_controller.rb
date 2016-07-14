class VenuesController < ApplicationController

  def index
    @venues = Venue.all(current_user)
  end

  def show
    @venue = Venue.find(current_user, params[:id])
    @venue_stats = @venue.check_in_stats(current_user)
    @venue_tips = @venue.tips(current_user)
  end

  def search
    @category = Venue.categories(current_user)
    if !params[:category]
      @venues_category_city = Venue.search_location_category(current_user, params[:city], params[:state], params[:category])
    else
      @venues = Venue.search_location(current_user, params[:city], params[:state])
    end
  end

end
