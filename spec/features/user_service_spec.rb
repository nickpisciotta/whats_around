require 'rails_helper'

describe UserService do
  context "#get_user_info" do
    it "returns user info" do
      VCR.use_cassette("user_info") do
      user_info = UserService.new.get_user_info("8766078")
      user = user_info["response"]["user"]

      expect(user["firstName"]).to eq("Nick")
      expect(user["lastName"]).to eq("Pisciotta")
      end
    end
  end

  context "#get_check_ins" do
    it "returns user check-ins" do
      VCR.use_cassette("user_check_in") do
      user_info = UserService.new.get_check_ins("8766078")
      user_check_ins = user_info["response"]["checkins"]["items"]

      expect(user_check_ins.first).to have_content(user_check_ins.first["name"])
      expect(user_check_ins.first).to have_content(user_check_ins.first["createdAt"])
      end
    end
  end
end
