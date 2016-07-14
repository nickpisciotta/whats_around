class User < ActiveRecord::Base
  attr_reader :user_name, :user_id

  def service
    @@service ||= UserService.new
  end

  def self.from_omniauth(auth_info)
    where(uid: auth_info[:uid]).first_or_create do |new_user|
      new_user.uid         = auth_info.uid
      new_user.name        = auth_info.info.name
      new_user.oauth_token = auth_info.credentials.token
    end
  end

  def photo(user)
    user_photo_hash = self.service.get_user_info(user.uid)
    user_photo_prefix = user_photo_hash["response"]["user"]["photo"]["prefix"]
    user_photo_suffix = user_photo_hash["response"]["user"]["photo"]["suffix"]
    user_photo_prefix + user_photo_suffix.split("/")[1]
  end

  def user_name(user)
    user_name_hash = self.service.get_user_info(user.uid)
    user_name_first = user_name_hash["response"]["user"]["firstName"]
    user_name_last = user_name_hash["response"]["user"]["lastName"]
    user_name_first + user_name_last
  end

  def check_in_count(user)
    check_ins_hash = self.service.get_check_ins(user.uid)
    check_ins_count = check_ins_hash["response"]["checkins"].first[1]
  end

  def last_check_ins(user)
    last_checkin_hash = self.service.get_check_ins(user.uid)
    top_5_check_ins = last_checkin_hash["response"]["checkins"]["items"][0..4]
    venues_of_check_ins = top_5_check_ins.map { |check_in| Venue.new(check_in["venue"]) }
    time_of_check_ins = top_5_check_ins.map { |check_in| format_date(check_in["createdAt"]) }
    venues_of_check_ins.zip(time_of_check_ins)
  end

  def format_date(epoch_time)
    date_time = DateTime.strptime("#{epoch_time}", "%s")
    date_time.strftime("%m%d%Y")
  end
end
