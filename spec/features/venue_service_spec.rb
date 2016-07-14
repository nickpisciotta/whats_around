require 'rails_helper'

describe VenueService do
  context "#get_venues" do
    it "returns venue info" do
      VCR.use_cassette("venue_info") do
      venue_info = VenueService.new.get_venues
      venue = venue_info["response"]["venues"]["items"]

      expect(venue.first).to have_content(venue.first["name"])
      end
    end
  end

  context "#get_venue_basic_info" do
    it "returns basic info for venue" do
      VCR.use_cassette("basic_venue_info") do
      venue_info = VenueService.new.get_venue_basic_info("4bb9038f53649c74e49c47fb")
      venue = venue_info["response"]["venue"]

      expect(venue["name"]).to eq("Colorado Athletic Club - Tabor")
      expect(venue["location"]["address"]).to eq("1201 16th St Unit 300")
      end
    end
  end

  context "#get_categories" do
    it "returns categories" do
      VCR.use_cassette("category") do
      category_info = VenueService.new.get_categories
      category = category_info["response"]["categories"].first
  
      expect(category).to have_content(category["name"])
      expect(category).to have_content(category["id"])
      end
    end
  end

end
