class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end
  def new
    @user = User.new
  end
  def create
    permitted = user_params
    @user = User.new(:name => permitted[:name],:email => permitted[:email])    # Not the final implementation!
    @user.password = permitted[:password]
    @user.password_confirmation = permitted[:password_confirmation]
    if @user.save
	  sign_in @user
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render 'new'
    end
  end
  private
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end