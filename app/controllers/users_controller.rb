class UsersController < ApplicationController

  before_action :logged_in?, only: [:show]

  def index
    @users = User.all
  end

  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.create(user_params)
    login(@user) # <-- login the user
    redirect_to @user # <-- go to show
  end

  def show
    @user = User.find_by_id params[:id]
    if @user != current_user
      redirect_to root_path
    end
  end

  def destroy
  # only let current_user delete their own account
  @user = User.find_by_id params[:id]
    if current_user == @user
      @user.destroy
      session[:user_id] = nil
      flash[:notice] = "Successfully deleted profile."
      redirect_to root_path
    else
      redirect_to user_path(current_user)
    end
  end

private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password)
  end

end
