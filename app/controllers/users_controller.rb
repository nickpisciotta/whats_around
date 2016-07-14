class UsersController < ApplicationController

  def show
    @user_check_ins_total = current_user.check_in_count(current_user)
    @user_name = current_user.user_name(current_user)
    @user_photo = current_user.photo(current_user)
    @last_5_check_ins = current_user.last_check_ins(current_user)
  end
end
