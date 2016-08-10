class RegistrationsController < Devise::RegistrationsController
  before_action :is_signed_in?, only:[:new]#沒有登入的話是不能新增使用者的
  skip_before_filter :require_no_authentication, only: [:new, :create]# you can go to sign up page when you try to sign up another user 
  def new
    super
  end
  
  def create
    super
  end
  
  def is_signed_in?#沒有登入的話是不能新增使用者，也就是說也不能自己註冊。
     if !user_signed_in?
        redirect_to user_session_path, alert: '請先登入'
     end
  end
  
  protected
  
  def after_update_path_for(resource)
    case resource
    when :user, User
      resource.teacher? ? another_path : users_path
    else
      super
    end
  end
  
  def after_inactive_sign_up_path_for(resource) #after sending the email for confirmation, we will direct the web page to the users_path
    users_path
  end
end