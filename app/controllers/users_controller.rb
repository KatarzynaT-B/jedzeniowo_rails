class UsersController < ApplicationController
  before_action :set_user, except: [:new, :create, :index]
  before_action :signed_in_user, only: [:edit, :update, :index, :destroy]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_only, only: [:index, :destroy]
  before_action :not_allowed_for_user, only: [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      sign_in @user
      flash[:success] = t 'flash.users.create.success'
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
      flash[:success] = t 'flash.shared.update.success', target: "zmiany"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def index
    @users = User.paginate(page: params[:page], per_page: 5)
  end

  def destroy
    @user.destroy
    flash[:success] = t 'flash.shared.destroy.success', target: "użytkownika"
    redirect_to users_url
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    def set_user
      @user = User.find(params[:id])
    end

    def not_allowed_for_user
      if signed_in?
        redirect_to(root_url)
        flash[:notice] = t 'flash.users.not_allowed.notice'
      end
    end

    def admin_only
      redirect_to(root_url) unless current_user.admin?
    end

    def correct_user
      redirect_to(root_url) unless current_user?(@user)
    end
end
