class UsersController < ApplicationController
  before_filter :authenticate_user!
  before_action :check_identity
  before_action :set_user, only: [:show, :destroy, :setIdentity]
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
 

 
  def setIdentity
  	if @user.role == GLOBAL_VAR['manager'].to_i
  		@user.role =  GLOBAL_VAR['user'].to_i
  	else
  		@user.role =  GLOBAL_VAR['manager'].to_i	
  	end
  	@user.save!
    redirect_to "/users", notice: "成功更改使用者權限"	
  end
 
  private
  
  def check_identity
	if current_user.role == GLOBAL_VAR['user'].to_i
		redirect_to "/projects", notice: "抱歉，您沒有權限"  		
	end		
  end  
  
  def set_user
    @user = User.find(params[:id])
  end

  def user_params
  end
end
