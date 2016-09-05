class UsersController < ApplicationController
  def new
  end


  def create
    @user = User.new(user_params)
    if @user.create
      session[:user_id] = @user.id
      @user.yodlee.register if Yodlee::Config.register_users
      redirect_to root_path
    else
      render :new
    end
  end

  def destroy
    @user = current_user
    @user.yodlee.destroy if Yodlee::Config.register_users
    @user.destroy
    reset_session
    redirect_to root_path
  end
end
