class User < ActiveRecord::Base
  attr_reader :user_name, :user_id

  def initialize(request)
    @user_name = request.info.name
    @user_id = request.uid
  end

  def service(user)
    @@service ||= UserService.new(user)
  end

  def self.from_omniauth(auth_info)
    where(uid: auth_info[:uid]).first_or_create do |new_user|
      new_user.uid         = auth_info.uid
      new_user.name        = auth_info.info.name
      new_user.oauth_token = auth_info.credentials.token
    end
  end


  def photo(user)
    user_photo_hash = self.service(user).get_user_info(user.uid)
    user_photo_prefix = user_photo_hash["response"]["user"]["photo"]["prefix"]
    user_photo_suffix = user_photo_hash["response"]["user"]["photo"]["suffix"]
    user_photo_prefix + user_photo_suffix.split("/")[1]
  end

  def user_name(user)
    user_name_hash = self.service(user).get_user_info(user.uid)
    user_name_first = user_name_hash["response"]["user"]["firstName"]
    user_name_last = user_name_hash["response"]["user"]["lastName"]
    user_name_first + user_name_last
  end

  def check_in_count(user)
    check_ins_hash = self.service(user).get_check_ins(user.uid)

    check_ins_count = check_ins_hash["response"]["checkins"].first[1]
  end

  def last_check_ins(user)
    last_checkin_hash = self.service(user).get_check_ins(user.uid)
    top_5_check_ins = last_checkin_hash["response"]["checkins"]["items"][0..4]
    byebug
    venues_of_check_ins = top_5_check_ins.map { |check_in| Venue.new(check_in["venue"]) }
    time_of_check_ins = top_5_check_ins.map { |check_in| format_date(check_in["createdAt"]) }
    venues_of_check_ins.zip(time_of_check_ins)
  end

  def format_date(epoch_time)
    date_time = DateTime.strptime("#{epoch_time}", "%s")
    date_time.strftime("%m%d%Y")
  end


  # def tips(user)
  #   tips_hash = self.service(user).get_tips(user.uid)
  #   tips_name_and_text = tips_hash.map do |tip|
  #    tip["response"]["tips"]["items"]["venue"]["name"] + ": " + tip["response"]["tips"]["items"]["text"]
  #   end
  #  byebug
  # end

  # def self.find(params_id)
  #   User.new(service.get_user(params_id))
  # end

end
