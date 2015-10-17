class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :destroy]
  skip_before_filter :authenticate_user!, only: :show
  def index
    listing_users
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(user_params)
    
    respond_to do |format|
      if @user.save
        listing_users
        format.js 
      else
        format.js { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        listing_users
        format.js 
      else
        format.js { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @user.destroy
    listing_users
    respond_to do |format|
      format.js { render :index }
    end
  end

  private
    def listing_users
      @users = User.players.order("first_name, last_name")
    end
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params[:user].permit(:first_name, :last_name)
    end
end
