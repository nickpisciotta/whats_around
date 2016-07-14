class VenuesController < ApplicationController

  def index
    @venues = Venue.all
  end

  def show
    @venue = Venue.find(params[:id])
    @venue_stats = @venue.check_in_stats
    @venue_tips = @venue.tips
  end

  def search
    @category = Venue.categories
    if params[:category]
      @venues_category_city = Venue.search_location_category(params[:city], params[:state], params[:category])
    else
      @venues = Venue.search_location(params[:city], params[:state])
    end
  end
end
