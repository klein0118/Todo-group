class MicropostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @microposts = @user.microposts.all
  end

  def new
    @user = User.find(params[:user_id])
    @micro = Micropost.new
  end

  def show
    @user = User.find(params[:user_id])
    @micro = @user.microposts.find(params[:id])
  end

  def edit
    @user = User.find(params[:user_id])
    @micro = @user.microposts.find(params[:id])
  end

  def create
    @user = User.find(params[:user_id])
    @micro = @user.microposts.create(micro_params)
    if @micro.save
      redirect_to user_micropost_path(@user, @micro)
    else
      render 'new'
    end
  end

  def update
    @user = User.find(params[:user_id])
    @micro = @user.microposts.find(params[:id])
    if @micro.update(micro_params)
      redirect_to user_micropost_path(@user, @micro)
    else
      render 'edit'
    end
  end

  def destroy
    @user = User.find(params[:user_id])
    @micro = @user.microposts.find(params[:id])
    @micro.destroy
    redirect_to user_microposts_path(@user)
  end

  private
    def micro_params
      params.require(:micropost).permit(:content)
    end
end
