class UserService

  def initialize
    @_connection = Faraday.new("https://api.foursquare.com/v2")
    @_connection.params["oauth_token"] = ENV["foursquare_oauth_token"]
    @_connection.params["v"] = "20160712"
  end

  def get_user_info(u_id)
    response = connection.get("/v2/users/#{u_id}")
    parse(response)
  end

  def get_check_ins(u_id)
    response = connection.get("/v2/users/#{u_id}/checkins")
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
