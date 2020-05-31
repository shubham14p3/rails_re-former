class UsersController < ApplicationController
  def new
    @user = User.new
    @user.email ||= 'example@example.com'
  end

  def create
    # @user = User.new(username: params[:username], email: params[:email], password: params[:password])

    @user = User.new(user_params)
    if @user.save
      flash.notice = "User '#{@user.username}' Created"
      redirect_to new_user_path
    else
      flash.notice = "User '#{@user.username}' not created"
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      flash.notice = "User '#{@user.username}' Updated"
      redirect_to edit_user_path

    else
      flash.notice = "User '#{@user.username}' Error"
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end
end
