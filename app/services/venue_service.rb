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

  def get_venue
    response = @connection.get
  end



  def parse(response)
    JSON.parse(response.body)
  end

end
