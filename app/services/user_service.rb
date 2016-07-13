class UserService

  def initialize(user)
    @user = user
    @connection = Faraday.new("https://api.foursquare.com/v2")
    @connection.params["oauth_token"] = @user.oauth_token
    @connection.params["v"] = "20160712"
  end

  def get_name

  end

  # def get_user(id)
  #   response = @connection.get("/api/v1/artists/#{id}.json")
  #   parse(response)
  # end

  def get_check_ins(u_id)
    response = @connection.get("/v2/users/#{u_id}/checkins")
    parse(response)
  end

  def parse(response)
    JSON.parse(response.body)
  end


end
