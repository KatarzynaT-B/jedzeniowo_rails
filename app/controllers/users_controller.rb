class UsersController < ApplicationController
  before_action :set_user, except: [:new, :create, :index]
  before_action :signed_in_user, only: [:edit, :update, :index]
  before_action :correct_user, only: [:edit, :update]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      sign_in @user
      flash[:success] = "Witamy w Jedzeniowie!"
      redirect_to @user
    else
      render 'new'
    end
  end

  def show
  end

  def edit
  end

  def update
    if @user.update_attributes(user_params)
      flash[:success] = "Zmiany zostały zapisane"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def index
    @users = User.all
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    def set_user
      @user = User.find(params[:id])
    end

    def signed_in_user
      unless signed_in?
        store_location
        redirect_to signin_url, notice: "Musisz się zalogować, żeby obejrzeć zawartość tej strony"
      end
    end

    def correct_user
      redirect_to(root_url) unless current_user?(@user)
    end
end
