class UsersController < ApplicationController
  before_filter :authenticate_user!
  before_action :check_identification
  before_action :set_user, only: [:show, :destroy]
  def index
    @users = User.all
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
        redirect_to "/users", notice: "成功刪除使用者"
    end
  end
 
  def check_identification
	unless current_user.email == 'shihweiyao@hotmail.com' or current_user.email == 'smhuang@mail.nctu.edu.tw' or current_user.email == 'bennylin77@gmail.com'  
		redirect_to "/projects", notice: "抱歉，您沒有權限"  		
	end		
  end
 
  
  private
  def set_user
    @user = User.find(params[:id])
  end

  def user_params
  end
end
