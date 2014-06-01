class UsersController < ApplicationController
# http://stackoverflow.com/questions/17565784/before-filter-in-action-mailer-rails-3
#  before_action :signed_in_user, only: [:edit, :update]
  include AbstractController::Callbacks
  before_filter :signed_in_user, only: [:index, :edit, :update, :destroy]
  before_filter :correct_user,   only: [:edit, :update]
  before_filter :admin_user,     only: :destroy
  def index
    @users = User.paginate(page: params[:page])
  end
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
  def edit
# don't need the following due to before_filter
#    @user = User.find(params[:id])
  end
  def update
    permitted = user_params
# don't need the following due to before_filter
#    @user = User.find(params[:id])
    @user.password = permitted[:password]
    @user.password_confirmation = permitted[:password_confirmation]
    if @user.update_attributes(:name => permitted[:name],:email => permitted[:email])
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted."
    redirect_to users_url
  end
  private
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
    # Before filters
    def signed_in_user
      unless signed_in?
        store_location
        redirect_to signin_url, notice: "Please sign in."
      end
    end
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end