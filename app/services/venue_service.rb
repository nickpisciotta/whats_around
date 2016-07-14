class VenueService

  def initialize
    @_connection = Faraday.new("https://api.foursquare.com/v2")
    @_connection.params["oauth_token"] = ENV["foursquare_oauth_token"]
    @_connection.params["v"] = "20160712"
  end

  def get_venues
    response = connection.get("/v2/users/self/venuehistory")
    parse(response)
  end

  def get_venue_basic_info(v_id)
    response = connection.get("/v2/venues/#{v_id}")
    parse(response)
  end

  def get_categories
    response = connection.get("/v2/venues/categories")
    parse(response)
  end

  def get_venues_by_location(location)
    response = connection.get("/v2/venues/search?near=#{location}")
    parse(response)
  end

  def get_venue_by_location_category(category_id, location)
    response = connection.get("/v2/venues/search?categoryId=#{category_id}&near=#{location}")
    parse(response)
  end

  def get_tips(venue_id)
    response = connection.get("/v2/venues/#{venue_id}/tips")
    parse(response)
  end

  def parse(response)
    JSON.parse(response.body)
  end

  private
    def connection
      @_connection
    end
end
