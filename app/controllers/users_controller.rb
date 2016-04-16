class UsersController < ApplicationController
  before_filter :authenticate_user!
  def index
    @users = User.all
  end

  def new
  end
  
  def edit
  end
  
  def update
    if @user.update(user_params)
      sign_in(@user == current_user ? @user : current_user, :bypass => true)
      flash[:notice] ='成功更改個人資料'
      redirect_to controller: 'users', action: 'edit', id: current_user
    else
      render 'edit'
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
    #params.require(:user).permit(accessible)
  end
end
