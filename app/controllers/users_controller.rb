class UsersController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_user, only: [:show, :destroy]
  def index
    @users = User.all
  end

  def show
  end
  #def edit
  #end
  
  #def update
  #  if @user.update_with_password(user_params)
  #    sign_in(@user == current_user ? @user : current_user, :bypass => true)
  #    flash[:notice] ='成功更改個人資料'
  #    redirect_to controller: 'users', action: 'edit', id: current_user
  #  else
  #    render 'edit'
  #  end
  #end
  
  def destroy
    if @user.destroy
        redirect_to root_url, notice: "成功刪除使用者"
    end
  end
  
  private
  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    #params[:user][:phone_no] = params[:phone_no_full]
    #accessible = [ :first_name, :last_name, :avatar, :phone_no, :email, 
    #               addresses_attributes:[:id, :postal, :county, :district, :address]] 
    #params.require(:user).permit(:email, :current_password, :password, :password_confirmation)
  end
end
