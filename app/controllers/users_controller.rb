class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :destroy]
  skip_before_filter :authenticate_user!, only: :show
  def index
    list_of_users
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
        list_of_users
        format.js 
      else
        format.js { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        list_of_users
        format.js 
      else
        format.js { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @user.destroy
    list_of_users
    respond_to do |format|
      format.js { render :index }
    end
    #redirect_to users_path, format: 'js'
  end

  def list_of_users
    @users = User.players.order("first_name, last_name")
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params[:user].permit(:first_name, :last_name)
    end
end
