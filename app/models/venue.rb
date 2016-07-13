class Venue < OpenStruct

  def self.service(user)
    @@service ||= VenueService.new(user)
  end

  def self.all(user)
    venues_hash = service(user).get_venues
    venues_data = venues_hash["response"]["venues"]["items"]
    venues_data.map do |venue_data|
      Venue.new(venue_data)
    end
  end

  def self.find(params_id)
    Venue.new(service.get_venue(params_id))
  end


end
