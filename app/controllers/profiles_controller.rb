class ProfilesController < ApplicationController
  before_action :signed_in_user
  before_action :set_profile, only: [:edit, :update, :show, :destroy]
  include ProfilesHelper

  def index
    @profiles = @current_user.profiles.paginate(page: params[:page], per_page: 5)
    redirect_to new_profile_path if @profiles.empty?
  end

  def new
    @profile = @current_user.profiles.new
  end

  def create
    @profile = @current_user.profiles.build(profile_params)
    if @profile.save
      redirect_to @profile
      flash[:success] = (t 'flash.shared.create.success', target: "profil")
    else
      render action: 'new'
    end
  end

  def edit
  end

  def update
    if @profile.update(profile_params)
      redirect_to @profile
      flash[:success] = (t 'flash.shared.update.success', target: "profil")
    end
  end

  def show
  end

  def destroy
    @profile.destroy
    flash[:success] = (t 'flash.shared.destroy.success', target: "profil")
    redirect_to profiles_url
  end

  private

    def profile_params
      params.require(:profile).permit(:name, :gender, :age, :weight, :height, :activity_level, :calories_need, :protein_need, :fat_need, :carbs_need)
    end

  def set_profile
    @profile = @current_user.profiles.find(params[:id])
  end
end
