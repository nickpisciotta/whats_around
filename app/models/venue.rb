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

  def self.find(user, params_id)
    venue = service(user).get_venue_basic_info(params_id)
    Venue.new(venue["response"]["venue"])
  end

  def self.categories(user)
    category_hash = service(user).get_categories
    categories = category_hash["response"]["categories"]
    categories.map do |category|
      Category.new(category)
    end
  end

  def self.search_location(user, city, state)
   if city
     location = city + ", " + state
     search_venue_hash  = service(user).get_venues_by_location(location)
     top_search_venues = search_venue_hash["response"]["venues"][0..20]
     top_search_venues.map do |venue|
       Venue.new(venue)
      end
    else
      nil
    end
  end


end
