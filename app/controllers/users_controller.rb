class UsersController < ApplicationController

  def show
    @user_check_ins = current_user.check_ins(current_user)
    @user_name = @user.user_name
    @user_photo = @user.photo
    @user_tips = @user.tips
  end
end
