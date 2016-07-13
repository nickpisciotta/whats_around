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

  # def self.find(params_id)
  #   User.new(service.get_user(params_id))
  # end

  def self.photo
  end

  def check_ins(user)
    check_ins_hash = self.service(user).get_check_ins(user.uid)
    byebug
  end

  # def self.tips(@user_id)
  #
  # end


end
