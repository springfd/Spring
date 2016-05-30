class RegistrationsController < Devise::RegistrationsController
  skip_before_filter :require_no_authentication, only: [:new, :create]# you can go to sign up page when you try to sign up another user 

  def new
    super
  end
  
  def create
    super
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