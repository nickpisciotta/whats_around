class Venue < OpenStruct

  def self.service
    @@service ||= VenueService.new
  end

  def self.all
    venues_hash = service.get_venues
    venues_data = venues_hash["response"]["venues"]["items"]
    venues_data.map do |venue_data|
      Venue.new(venue_data)
    end
  end

  # def create_venues_objects(parsed_data_sets)
  #   map do |parsed_data_set|
  #     Venue.new(parsed_data_set)
  #   end
  # end

  def self.find(params_id)
    venue = self.service.get_venue_basic_info(params_id)
    Venue.new(venue["response"]["venue"])
  end

  def self.categories
    category_hash = service.get_categories
    categories = category_hash["response"]["categories"]
    categories.map do |category|
      Category.new(category)
    end
  end

  def self.search_location(city, state)
   if city && state
     location = city + ", " + state
     search_venue_hash  = service.get_venues_by_location(location)
     top_search_venues = search_venue_hash["response"]["venues"][0..20]
     top_search_venues.map do |venue|
       Venue.new(venue)
      end
    else
      nil
    end
  end

  def self.search_location_category(city, state, category_id)
    if city && state && category_id
      location = city + ", " + state
      category_location_search_hash = service.get_venue_by_location_category(category_id, location)
      category_location_search = category_location_search_hash["response"]["venues"][0..20]
      category_location_search.map do |venue|
        Venue.new(venue)
      end
    else
      nil
    end
  end

  def tips
    tips_hash = service.get_tips(self.id)
    tips = tips_hash["response"]["tips"]["items"][0..4]
    tips.map {|tip| tip["text"]}
  end

private
  def service
    @@service ||= VenueService.new
  end
end
