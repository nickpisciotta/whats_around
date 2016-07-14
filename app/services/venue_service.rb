class VenueService

  def initialize(user)
    @user = user
    @connection = Faraday.new("https://api.foursquare.com/v2")
    @connection.params["oauth_token"] = @user.oauth_token
    @connection.params["v"] = "20160712"
  end

  def get_venues
    response = @connection.get("/v2/users/self/venuehistory")
    parse(response)
  end

  def get_venue_basic_info(v_id)
    response = @connection.get("/v2/venues/#{v_id}")
    parse(response)
  end

  def get_stats(venue_id)
    response = @connection.get("/v2/venues/#{venue_id}/stats")
    parse(response)
  end

  def get_categories
    response = @connection.get("/v2/venues/categories")
    parse(response)
  end

  def get_venues_by_location(location)
    response = @connection.get("/v2/venues/search?near=#{location}")
    parse(response)
  end

  def get_venue_by_location_category(category_id, location)
    response = @connection.get("/v2/venues/search?categoryId=#{category_id}&near=#{location}")
    parse(response)
  end

  def get_tips(venue_id)
    response = @connection.get("/v2/venues/#{venue_id}/tips")
    parse(response)
  end


  def parse(response)
    JSON.parse(response.body)
  end

end
